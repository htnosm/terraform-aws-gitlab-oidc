module "gitlab_oidc_iam_roles" {
  source = "../../"

  create_oidc_provider = false
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
}

output "gitlab_oidc_iam_roles" {
  value = module.gitlab_oidc_iam_roles.oidc_iam_roles
}
