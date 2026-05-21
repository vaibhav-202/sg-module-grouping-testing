# cloudwatch-log-group

Creates a CloudWatch log group with configurable retention.

## Usage

```hcl
module "log_group" {
  source = "../../modules/cloudwatch-log-group"

  log_group_name    = "/aws/lambda/my-function"
  retention_in_days = 14
}
```

## Inputs

| Name | Type | Default | Description |
|---|---|---|---|
| `log_group_name` | `string` | required | Name of the log group |
| `retention_in_days` | `number` | `30` | Log retention in days |
| `kms_key_id` | `string` | `null` | KMS key for encryption (optional) |
| `tags` | `map(string)` | `{}` | Additional tags |

## Outputs

| Name | Description |
|---|---|
| `log_group_arn` | ARN of the log group |
| `log_group_name` | Name of the log group |
| `log_group_id` | ID of the log group |
