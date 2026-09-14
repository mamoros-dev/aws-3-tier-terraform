# --- Terraform Backend Configuration ---
# --- Configuración del backend de Terraform ---
terraform {
  backend "s3" {
    bucket         = "miguel-terraform-state-proyecto2"
    key            = "proyecto2/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "terraform-locks-proyecto2"
    encrypt        = true
  }
}
