variable "rule_name" {
  description = "Name of the EventBridge Scheduler schedule"
  type        = string
}

variable "schedule_expression" {
  description = "Schedule expression — cron(...), rate(...), or at(...)"
  type        = string
}

variable "schedule_expression_timezone" {
  description = "IANA timezone for the schedule expression (e.g. Europe/Berlin). Defaults to UTC."
  type        = string
  default     = "UTC"
}

variable "target_arn" {
  description = "ARN of the Lambda function to invoke"
  type        = string
}

variable "target_input_json" {
  description = "JSON payload passed to the Lambda target on each invocation"
  type        = string
  default     = "{}"
}

variable "tags" {
  description = "Additional tags to apply to created resources"
  type        = map(string)
  default     = {}
}

variable "invoker_role_arn" {
  description = "Pre-existing IAM role ARN for EventBridge Scheduler to assume when invoking the target. When set, skips internal invoker role creation."
  type        = string
  default     = ""
}
