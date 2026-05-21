# lambda

Creates a container-image Lambda function. Image lifecycle is managed outside Terraform (CI/CD pushes to ECR); `image_uri` is intentionally ignored after initial creation.

## Usage

```hcl
module "lambda" {
  source = "../../modules/lambda"

  function_name = "my-function"
  image_uri     = "123456789.dkr.ecr.eu-central-1.amazonaws.com/my-function:latest"
  role          = module.role.role_arn
  memory_size   = 512
  timeout       = 30
}
```

## Inputs

| Name | Type | Default | Description |
|---|---|---|---|
| `function_name` | `string` | required | Function name |
| `image_uri` | `string` | required | Container image URI |
| `role` | `string` | required | IAM execution role ARN |
| `architecture` | `string` | `"x86_64"` | `x86_64` or `arm64` |
| `memory_size` | `number` | `128` | Memory in MB |
| `ephemeral_storage_size` | `number` | `512` | /tmp size in MB |
| `timeout` | `number` | `900` | Timeout in seconds |
| `reserved_concurrent_executions` | `number` | `-1` | Concurrency limit (-1 = unreserved) |
| `environment_variables` | `map(string)` | `{}` | Environment variables |
| `subnet_ids` | `list(string)` | `[]` | VPC subnets (empty = no VPC) |
| `security_group_ids` | `list(string)` | `[]` | VPC security groups |
| `file_system_config` | `object` | `null` | EFS mount (arn, local_mount_path) |
| `tags` | `map(string)` | `{}` | Additional tags |

## Outputs

| Name | Description |
|---|---|
| `function_arn` | Function ARN |
| `function_name` | Function name |
| `invoke_arn` | Invoke ARN (for API Gateway) |
| `qualified_arn` | Qualified ARN with version |

## Notes

- Log group `/aws/lambda/<function_name>` is wired via `logging_config` — create it separately (e.g. `modules/cloudwatch-log-group`) to control retention.
- `image_uri` changes are ignored after creation. Update the image tag by pushing to ECR; Lambda picks it up on next cold start or via `aws lambda update-function-code`.
