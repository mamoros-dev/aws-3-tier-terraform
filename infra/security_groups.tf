# --- Security Group del ALB: recibe tráfico de internet ---
resource "aws_security_group" "alb" {
  name        = "proyecto2-alb-sg"
  description = "Permite HTTP entrante desde internet hacia el ALB"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "HTTP desde cualquier origen"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Todo el trafico saliente permitido"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "proyecto2-alb-sg"
  }
}

# --- Security Group de las instancias de aplicación: solo recibe del ALB ---
resource "aws_security_group" "app" {
  name        = "proyecto2-app-sg"
  description = "Permite trafico solo desde el Security Group del ALB"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "Trafico de la app solo desde el ALB"
    from_port       = var.app_port
    to_port         = var.app_port
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
  }

  egress {
    description = "Todo el trafico saliente permitido"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "proyecto2-app-sg"
  }
}

# --- Security Group de RDS: solo recibe de las instancias de aplicación ---
resource "aws_security_group" "rds" {
  name        = "proyecto2-rds-sg"
  description = "Permite PostgreSQL solo desde el Security Group de aplicacion"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "PostgreSQL solo desde las instancias de app"
    from_port       = var.db_port
    to_port         = var.db_port
    protocol        = "tcp"
    security_groups = [aws_security_group.app.id]
  }

  egress {
    description = "Todo el trafico saliente permitido"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "proyecto2-rds-sg"
  }
}
