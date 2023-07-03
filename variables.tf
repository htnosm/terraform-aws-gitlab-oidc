variable "create_oidc_provider" {
  description = "Create a new identity provider."
  type        = bool
  default     = true
}

variable "gitlab_oidc_domain" {
  description = "The domain of the identity provider. Corresponds to the iss claim."
  type        = string
  default     = "gitlab.com"
}

variable "iam_roles" {
  description = <<-EOT
    {
        "iam_role_name": {
            #e.g. `["project_path:mygroup/myproject:ref_type:branch:ref:main"]`
            oidc_claims = ["A list of server certificate thumbprints for the OpenID Connect (OIDC) identity provider's server certificate(s)."]
            #e.g. `["arn:aws:iam::aws:policy/ReadOnlyAccess"]`
            policy_arns = ["Set of IAM policy ARNs to attach to the IAM role."]
        }
    }
  EOT
  type = map(object({
    oidc_claims = list(string)
    policy_arns = list(string)
  }))
  default = {}
}

variable "tags" {
  description = "A mapping of tags to assign to resources."
  type        = map(string)
  default     = {}
}
