# --- Outputs for GitHub Actions IAM Role and OIDC Provider ---
# --- Salidas para el IAM Role de GitHub Actions y el Proveedor OIDC ---
output "github_actions_role_arn" {
  description = "ARN del IAM Role que GitHub Actions asumirá vía OIDC"
  value       = aws_iam_role.github_actions.arn
}

output "github_oidc_provider_arn" {
  description = "ARN del Identity Provider OIDC de GitHub"
  value       = aws_iam_openid_connect_provider.github_actions.arn
}
