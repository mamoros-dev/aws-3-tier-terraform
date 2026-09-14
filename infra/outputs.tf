# --- Terraform Output: load balancer dns name ---
# --- Salida de Terraform: nombre DNS del load balancer ---
output "alb_dns_name" {
  description = "DNS publico del Load Balancer - accede aqui para probar la app"
  value       = aws_lb.main.dns_name
}


# --- Terraform Output: RDS endpoint ---
# --- Salida de Terraform: endpoint de RDS ---
output "rds_endpoint" {
  description = "Endpoint de conexion a RDS"
  value       = aws_db_instance.main.address
}