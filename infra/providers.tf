# --- Terraform Configuration ---
# --- Configuración de Terraform ---
terraform {
  required_version = ">= 1.9.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# --- AWS Provider Configuration ---
# --- Configuración del proveedor de AWS ---
provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "aws-3-tier-terraform"
      Environment = "dev"
      ManagedBy   = "terraform"
      Owner       = "miguel"
    }
  }
}