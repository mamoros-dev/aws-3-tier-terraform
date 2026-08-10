output "alb_dns_name" {
  description = "DNS publico del Load Balancer - accede aqui para probar la app"
  value       = aws_lb.main.dns_name
}

output "rds_endpoint" {
  description = "Endpoint de conexion a RDS"
  value       = aws_db_instance.main.address
}