# --- Terraform Providers Configuration for CICD ---
# --- Configuración de los Proveedores de Terraform para CICD ---
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.5.0"
}

provider "aws" {
  region  = "eu-west-1"
  profile = "personal"
}
