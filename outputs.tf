output "oidc_provider" {
  value = var.create_oidc_provider ? aws_iam_openid_connect_provider.this["oidc_provider"] : data.aws_iam_openid_connect_provider.this["oidc_provider"]
}

output "oidc_iam_roles" {
  value = aws_iam_role.this
}