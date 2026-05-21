# eventbridge-schedule

Creates an EventBridge Scheduler schedule that invokes a Lambda function. Manages the schedule, the internally-created IAM invoker role (trusting `scheduler.amazonaws.com`), and the target binding in one shot. Supports IANA timezones and one-shot `at(...)` expressions.

## Usage

```hcl
module "schedule" {
  source = "../../modules/eventbridge-schedule"

  rule_name                    = "my-function-schedule"
  schedule_expression          = "cron(0 9 * * ? *)"
  schedule_expression_timezone = "Europe/Berlin"
  target_arn                   = module.lambda.function_arn
  target_input_json            = jsonencode({ key = "value" })
}
```

## Inputs

| Name | Type | Default | Description |
|---|---|---|---|
| `rule_name` | `string` | required | Schedule name |
| `schedule_expression` | `string` | required | `cron(...)`, `rate(...)`, or `at(...)` expression |
| `schedule_expression_timezone` | `string` | `"UTC"` | IANA timezone for the cron expression (e.g. `Europe/Berlin`, `America/New_York`) |
| `target_arn` | `string` | required | Lambda function ARN to invoke |
| `target_input_json` | `string` | `"{}"` | JSON payload passed to the Lambda target |
| `tags` | `map(string)` | `{}` | Additional tags |
| `invoker_role_arn` | `string` | `""` | Pre-existing IAM role ARN for Scheduler to assume. When set, skips internal invoker role creation (useful for shared cross-region roles). |

## Outputs

| Name | Description |
|---|---|
| `schedule_arn` | ARN of the EventBridge Scheduler schedule |
| `schedule_name` | Name of the schedule |
| `invoker_role_arn` | ARN of the IAM role used by the Scheduler to invoke the target |
