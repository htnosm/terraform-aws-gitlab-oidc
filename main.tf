/**
 * # terraform-aws-gitlab-oidc
 *
 * Configuring OpenID for GitLab Connect in Amazon Web Services
 *
 * ## Reference
 *
 * - [OIDC claims](https://docs.gitlab.com/ee/ci/cloud_services/index.html#configure-a-conditional-role-with-oidc-claims)
 * - [configure\-aws\-credentials](https://gitlab.com/aws-actions/configure-aws-credentials)
 *
 */

data "tls_certificate" "this" {
  url = "https://${var.gitlab_oidc_domain}/.well-known/openid-configuration"
}

locals {
  gitlab_thumbprints = sort(distinct(
    [for x in data.tls_certificate.this.certificates : x.sha1_fingerprint if x.is_ca]
  ))
}

data "aws_iam_openid_connect_provider" "this" {
  for_each = var.create_oidc_provider ? {} : { oidc_provider = false }

  url = "https://${var.gitlab_oidc_domain}"
}

resource "aws_iam_openid_connect_provider" "this" {
  for_each = var.create_oidc_provider ? { oidc_provider = true } : {}

  url             = "https://${var.gitlab_oidc_domain}"
  client_id_list  = ["https://${var.gitlab_oidc_domain}"]
  thumbprint_list = local.gitlab_thumbprints
  tags = merge(var.tags, {
    Name = var.gitlab_oidc_domain
  })
}

locals {
  aws_iam_openid_connect_provider = var.create_oidc_provider ? aws_iam_openid_connect_provider.this["oidc_provider"] : data.aws_iam_openid_connect_provider.this["oidc_provider"]
}

data "aws_iam_policy_document" "this_assume_role_policy" {
  for_each = var.iam_roles

  statement {
    effect = "Allow"
    principals {
      type        = "Federated"
      identifiers = [local.aws_iam_openid_connect_provider.arn]
    }
    actions = [
      "sts:AssumeRoleWithWebIdentity",
    ]
    condition {
      test     = "StringLike"
      variable = "${var.gitlab_oidc_domain}:sub"
      values   = each.value.oidc_claims
    }
  }
}

resource "aws_iam_role" "this" {
  for_each            = var.iam_roles
  name                = each.key
  assume_role_policy  = data.aws_iam_policy_document.this_assume_role_policy[each.key].json
  managed_policy_arns = each.value.policy_arns
  tags = merge(var.tags, {
    Name = each.key
  })
}
