# --- GitHub Actions OIDC Provider and IAM Role for Terraform ---
# --- Proveedor OIDC de GitHub Actions y Rol IAM para Terraform ---
resource "aws_iam_openid_connect_provider" "github_actions" {
  url = "https://token.actions.githubusercontent.com"

  client_id_list = [
    "sts.amazonaws.com"
  ]

  thumbprint_list = [
    "6938fd4d98bab03faadb97b34396831e3780aea1"
  ]
}
# --- IAM Role for GitHub Actions to Assume for Terraform ---
# --- Rol IAM para que GitHub Actions asuma para Terraform ---
data "aws_caller_identity" "current" {}

# --- IAM Policy Document for GitHub Actions Trust Relationship ---
# --- Documento de Política IAM para la Relación de Confianza de GitHub Actions ---
data "aws_iam_policy_document" "github_actions_trust" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.github_actions.arn]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["repo:mamoros-dev@55656115/aws-3-tier-terraform@1322122992:*"]
    }
  }
}

# --- IAM Role and Policy for GitHub Actions to Manage Terraform State and Provision Infrastructure ---
# --- Rol y Política IAM para que GitHub Actions gestione el estado de Terraform y aprovis
resource "aws_iam_role" "github_actions" {
  name               = "github-actions-terraform-role"
  assume_role_policy = data.aws_iam_policy_document.github_actions_trust.json
}

# --- IAM Policy Document for GitHub Actions Permissions ---
# --- Documento de Política IAM para los Permisos de GitHub Actions ---
data "aws_iam_policy_document" "github_actions_permissions" {
  statement {
    sid    = "TerraformStateBackend"
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:ListBucket"
    ]
    resources = [
      "arn:aws:s3:::miguel-terraform-state-proyecto2",
      "arn:aws:s3:::miguel-terraform-state-proyecto2/*"
    ]
  }

  statement {
    sid    = "TerraformStateLock"
    effect = "Allow"
    actions = [
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:DeleteItem"
    ]
    resources = [
      "arn:aws:dynamodb:eu-west-1:${data.aws_caller_identity.current.account_id}:table/terraform-locks-proyecto2"
    ]
  }

  statement {
    sid    = "InfraProvisioningRegional"
    effect = "Allow"
    actions = [
      "ec2:*",
      "elasticloadbalancing:*",
      "rds:*",
      "autoscaling:*"
    ]
    resources = ["*"]

    condition {
      test     = "StringEquals"
      variable = "aws:RequestedRegion"
      values   = ["eu-west-1"]
    }
  }

  statement {
    sid    = "InfraProvisioningIAMGlobal"
    effect = "Allow"
    actions = [
      "iam:GetRole",
      "iam:PassRole",
      "iam:CreateRole",
      "iam:DeleteRole",
      "iam:AttachRolePolicy",
      "iam:DetachRolePolicy",
      "iam:PutRolePolicy",
      "iam:DeleteRolePolicy",
      "iam:GetRolePolicy",
      "iam:ListRolePolicies",
      "iam:ListAttachedRolePolicies",
      "iam:CreateInstanceProfile",
      "iam:DeleteInstanceProfile",
      "iam:AddRoleToInstanceProfile",
      "iam:RemoveRoleFromInstanceProfile",
      "iam:GetInstanceProfile",
      "iam:TagRole",
      "iam:UntagRole",
      "iam:TagInstanceProfile",
      "iam:UntagInstanceProfile",
      "iam:ListInstanceProfilesForRole"
    ]
    resources = ["*"]
  }
}

# --- Attach the Policy to the IAM Role for GitHub Actions ---
# --- Adjuntar la Política al Rol IAM para GitHub Actions ---
resource "aws_iam_role_policy" "github_actions_permissions" {
  name   = "github-actions-terraform-permissions"
  role   = aws_iam_role.github_actions.id
  policy = data.aws_iam_policy_document.github_actions_permissions.json
}
