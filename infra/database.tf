# --- Agrupa las subredes de datos para que RDS sepa donde desplegarse ---
resource "aws_db_subnet_group" "main" {
  name       = "proyecto2-db-subnet-group"
  subnet_ids = aws_subnet.db[*].id

  tags = {
    Name = "proyecto2-db-subnet-group"
  }
}

# --- La instancia RDS PostgreSQL ---
resource "aws_db_instance" "main" {
  identifier     = "proyecto2-db"
  engine         = "postgres"
  engine_version = var.db_engine_version
  instance_class = var.db_instance_class

  allocated_storage = 20
  storage_type      = "gp3"

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.rds.id]

  multi_az            = false
  publicly_accessible = false
  skip_final_snapshot = true

  tags = {
    Name = "proyecto2-rds"
  }
}