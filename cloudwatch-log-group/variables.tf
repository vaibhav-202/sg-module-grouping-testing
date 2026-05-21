variable "log_group_name" {
  description = "Name of the CloudWatch log group"
  type        = string
}

variable "retention_in_days" {
  description = "Retention period in days"
  type        = number
  default     = 30
}

variable "kms_key_id" {
  description = "KMS key ID for encrypting the log group (optional)"
  type        = string
  default     = null
}

variable "tags" {
  description = "Additional tags to apply to the log group"
  type        = map(string)
  default     = {}
}
