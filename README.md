# terraform-aws-gitlab-oidc

Configuring OpenID for GitLab Connect in Amazon Web Services

## Reference

- [OIDC claims](https://docs.gitlab.com/ee/ci/cloud_services/index.html#configure-a-conditional-role-with-oidc-claims)
- [configure\-aws\-credentials](https://gitlab.com/aws-actions/configure-aws-credentials)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.4 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | >= 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.0 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | >= 4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_openid_connect_provider.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_openid_connect_provider.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_openid_connect_provider) | data source |
| [aws_iam_policy_document.this_assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [tls_certificate.this](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/data-sources/certificate) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_oidc_provider"></a> [create\_oidc\_provider](#input\_create\_oidc\_provider) | Create a new identity provider. | `bool` | `true` | no |
| <a name="input_gitlab_oidc_domain"></a> [gitlab\_oidc\_domain](#input\_gitlab\_oidc\_domain) | The domain of the identity provider. Corresponds to the iss claim. | `string` | `"gitlab.com"` | no |
| <a name="input_iam_roles"></a> [iam\_roles](#input\_iam\_roles) | {<br>    "iam\_role\_name": {<br>        #e.g. `["project_path:mygroup/myproject:ref_type:branch:ref:main"]`<br>        oidc\_claims = ["A list of server certificate thumbprints for the OpenID Connect (OIDC) identity provider's server certificate(s)."]<br>        #e.g. `["arn:aws:iam::aws:policy/ReadOnlyAccess"]`<br>        policy\_arns = ["Set of IAM policy ARNs to attach to the IAM role."]<br>    }<br>} | <pre>map(object({<br>    oidc_claims = list(string)<br>    policy_arns = list(string)<br>  }))</pre> | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_oidc_iam_roles"></a> [oidc\_iam\_roles](#output\_oidc\_iam\_roles) | n/a |
| <a name="output_oidc_provider"></a> [oidc\_provider](#output\_oidc\_provider) | n/a |
