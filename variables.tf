variable "aws_region" {
  description = "Región de AWS donde se despliega toda la infraestructura"
  type        = string
  default     = "eu-west-1"
}
variable "vpc_cidr" {
  description = "Bloque CIDR principal de la VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "Zonas de disponibilidad donde se despliega la infraestructura"
  type        = list(string)
  default     = ["eu-west-1a", "eu-west-1b"]
}

variable "public_subnet_cidrs" {
  description = "CIDRs de las subredes públicas (una por AZ), para el ALB"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "app_subnet_cidrs" {
  description = "CIDRs de las subredes privadas de aplicación (una por AZ), para las EC2"
  type        = list(string)
  default     = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "db_subnet_cidrs" {
  description = "CIDRs de las subredes privadas de datos (una por AZ), para RDS"
  type        = list(string)
  default     = ["10.0.21.0/24", "10.0.22.0/24"]
}

variable "app_port" {
  description = "Puerto en el que escucha la aplicación en las instancias EC2"
  type        = number
  default     = 80
}

variable "db_port" {
  description = "Puerto de PostgreSQL en RDS"
  type        = number
  default     = 5432
}

variable "instance_type" {
  description = "Tipo de instancia EC2 para el Auto Scaling Group"
  type        = string
  default     = "t3.micro"
}

variable "asg_desired_capacity" {
  description = "Numero deseado de instancias en el ASG"
  type        = number
  default     = 2
}

variable "asg_min_size" {
  description = "Numero minimo de instancias en el ASG"
  type        = number
  default     = 2
}

variable "asg_max_size" {
  description = "Numero maximo de instancias en el ASG"
  type        = number
  default     = 4
}

variable "db_name" {
  description = "Nombre de la base de datos inicial en RDS"
  type        = string
  default     = "proyecto2db"
}

variable "db_username" {
  description = "Usuario administrador de la base de datos"
  type        = string
  default     = "dbadmin"
}

variable "db_password" {
  description = "Contraseña del usuario administrador de RDS"
  type        = string
  sensitive   = true
}

variable "db_instance_class" {
  description = "Clase de instancia de RDS"
  type        = string
  default     = "db.t3.micro"
}

variable "db_engine_version" {
  description = "Version de PostgreSQL"
  type        = string
  default     = "16"
}