# --- El Load Balancer en sí ---
resource "aws_lb" "main" {
  name               = "proyecto2-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = aws_subnet.public[*].id

  tags = {
    Name = "proyecto2-alb"
  }
}

# --- Target Group: a donde el ALB reenvia el trafico ---
resource "aws_lb_target_group" "app" {
  name     = "proyecto2-app-tg"
  port     = var.app_port
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    matcher             = "200"
  }

  tags = {
    Name = "proyecto2-app-tg"
  }
}

# --- Listener: escucha en el puerto 80 y reenvia al Target Group ---
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }
}