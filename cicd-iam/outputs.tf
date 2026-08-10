output "github_actions_role_arn" {
  description = "ARN del IAM Role que GitHub Actions asumirá vía OIDC"
  value       = aws_iam_role.github_actions.arn
}

output "github_oidc_provider_arn" {
  description = "ARN del Identity Provider OIDC de GitHub"
  value       = aws_iam_openid_connect_provider.github_actions.arn
}
