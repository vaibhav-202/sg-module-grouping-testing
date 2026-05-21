# ecr

Creates an ECR repository with scan-on-push enabled and a lifecycle policy that expires untagged images beyond the last 10.

## Usage

```hcl
module "ecr" {
  source          = "../../modules/ecr"
  repository_name = "my-function"
}
```

## Inputs

| Name | Type | Default | Description |
|---|---|---|---|
| `repository_name` | `string` | required | Repository name |
| `tags` | `map(string)` | `{}` | Additional tags |

## Outputs

| Name | Description |
|---|---|
| `repository_url` | Full repository URL (used as Lambda `image_uri` prefix) |
| `repository_arn` | ARN of the repository |
| `repository_name` | Name of the repository |
