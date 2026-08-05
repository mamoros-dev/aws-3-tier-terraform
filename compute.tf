data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_launch_template" "app" {
  name_prefix   = "proyecto2-app-"
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type

  vpc_security_group_ids = [aws_security_group.app.id]

  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_ssm.name
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 2
  }

  user_data = base64encode(<<-EOF
    #!/bin/bash
    dnf install -y httpd php php-pgsql
    systemctl enable httpd
    systemctl start httpd
    echo "<?php phpinfo(); ?>" > /var/www/html/index.php
  EOF
  )

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "proyecto2-app-instance"
    }
  }
}

resource "aws_autoscaling_group" "app" {
  name                = "proyecto2-asg"
  vpc_zone_identifier = aws_subnet.app[*].id
  desired_capacity    = var.asg_desired_capacity
  min_size            = var.asg_min_size
  max_size            = var.asg_max_size

  launch_template {
    id      = aws_launch_template.app.id
    version = "$Latest"
  }

  target_group_arns = [aws_lb_target_group.app.arn]

  health_check_type         = "ELB"
  health_check_grace_period = 60

  tag {
    key                 = "Name"
    value               = "proyecto2-app-instance"
    propagate_at_launch = true
  }
}