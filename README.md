# Arquitectura Web de 3 Capas en AWS — con Terraform

Réplica en Infraestructura como Código de [aws-3-tier-web-architecture](https://github.com/mamoros-dev/aws-3-tier-web-architecture), 
desplegado manualmente en el proyecto anterior de este portfolio.

## Estado

En progreso.

## Stack

Terraform · AWS VPC · EC2 · Auto Scaling · Application Load Balancer · RDS PostgreSQL · IAM · Systems Manager Session Manager

## Decisiones de diseño

- **Backend remoto (S3 + DynamoDB)**: estado versionado, cifrado y con locking, en vez de estado local — imprescindible en cualquier equipo real.
- **Variables desde el inicio**: sin valores hardcodeados, pensado para reutilización en distintos entornos.
- **NAT Gateway única (no una por AZ)**: decisión de coste consciente para un proyecto de portfolio — en producción con tráfico real, sería una NAT por AZ para eliminar el punto único de fallo.
