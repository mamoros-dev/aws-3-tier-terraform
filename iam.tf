# --- Trust Policy: quién puede asumir este rol ---
data "aws_iam_policy_document" "ec2_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

# --- El Role en sí ---
resource "aws_iam_role" "ec2_ssm" {
  name               = "proyecto2-ec2-ssm-role"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json

  tags = {
    Name = "proyecto2-ec2-ssm-role"
  }
}

# --- Adjuntamos la política gestionada de AWS para SSM ---
resource "aws_iam_role_policy_attachment" "ssm" {
  role       = aws_iam_role.ec2_ssm.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# --- Instance Profile: el "envoltorio" que permite asignar el rol a una EC2 ---
resource "aws_iam_instance_profile" "ec2_ssm" {
  name = "proyecto2-ec2-ssm-profile"
  role = aws_iam_role.ec2_ssm.name
}
