module "gitlab_oidc_provider" {
  source = "../../"
  iam_roles = {
    "GitLabCICD-terrafrom-plan" : {
      oidc_claims = ["project_path:mygroup/myproject:ref_type:branch:ref:main"]
      policy_arns = ["arn:aws:iam::aws:policy/ReadOnlyAccess"]
    }
    "GitLabCICD-terrafrom-apply" : {
      oidc_claims = ["project_path:mygroup/myproject:ref_type:branch:ref:main"]
      policy_arns = ["arn:aws:iam::aws:policy/AdministratorAccess"]
    }
  }
  tags = {
    env = "example"
  }
}

output "gitlab_oidc_provider" {
  value = module.gitlab_oidc_provider.oidc_provider
}

output "gitlab_oidc_iam_roles" {
  value = module.gitlab_oidc_provider.oidc_iam_roles
}
