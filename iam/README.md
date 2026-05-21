# iam

Generic IAM module for creating roles, users, instance profiles, and attached policies. Use only the toggle(s) you need — everything else stays off by default.

## Usage — Lambda execution role

```hcl
module "role" {
  source      = "../../modules/iam"
  create_role = true
  role_name   = "my-function-exec"
  trust_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Action    = "sts:AssumeRole"
      Principal = { Service = "lambda.amazonaws.com" }
    }]
  })
  role_managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole",
  ]
}
```

## Inputs

| Name | Type | Default | Description |
|---|---|---|---|
| `create_role` | `bool` | `false` | Create an IAM role |
| `role_name` | `string` | `""` | Role name |
| `trust_policy` | `string` | `""` | Assume-role trust policy JSON |
| `create_user` | `bool` | `false` | Create an IAM user |
| `user_name` | `string` | `""` | User name |
| `create_instance_profile` | `bool` | `false` | Create an EC2 instance profile |
| `custom_policies` | `list(object)` | `[]` | Inline policies to create (name, description, policy JSON) |
| `managed_policy_arns` | `list(string)` | `[]` | ARNs attached to both role and user |
| `role_managed_policy_arns` | `list(string)` | `[]` | ARNs attached to role only |
| `user_managed_policy_arns` | `list(string)` | `[]` | ARNs attached to user only |
| `additional_tags` | `map(string)` | `{}` | Additional tags |

## Outputs

| Name | Description |
|---|---|
| `role_arn` | IAM role ARN (null when `create_role = false`) |
| `role_name` | IAM role name |
| `user_arn` | IAM user ARN (null when `create_user = false`) |
| `user_name` | IAM user name |
| `instance_profile_arn` | Instance profile ARN |
| `instance_profile_name` | Instance profile name |
| `custom_policy_arns` | Map of custom policy ARNs keyed by name |
| `custom_policy_names` | Map of custom policy names |
