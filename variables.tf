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
