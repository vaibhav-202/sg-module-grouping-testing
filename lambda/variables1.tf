variable "function_name" {
  description = "Name of the Lambda function"
  type        = string
}

variable "image_uri" {
  description = "ECR image URI for the Lambda function"
  type        = string
}

variable "role" {
  description = "IAM execution role ARN"
  type        = string
}

variable "architecture" {
  description = "Instruction set architecture — x86_64 or arm64"
  type        = string
  default     = "x86_64"

  validation {
    condition     = contains(["x86_64", "arm64"], var.architecture)
    error_message = "architecture must be x86_64 or arm64"
  }
}

variable "memory_size" {
  description = "Memory in MB allocated to the function"
  type        = number
  default     = 128
}

variable "ephemeral_storage_size" {
  description = "Ephemeral /tmp storage in MB"
  type        = number
  default     = 512
}

variable "timeout" {
  description = "Function timeout in seconds"
  type        = number
  default     = 900
}

variable "reserved_concurrent_executions" {
  description = "Reserved concurrency limit (-1 = unreserved)"
  type        = number
  default     = -1
}

variable "environment_variables" {
  description = "Environment variables for the function"
  type        = map(string)
  default     = {}
}

variable "subnet_ids" {
  description = "VPC subnet IDs (empty = no VPC attachment)"
  type        = list(string)
  default     = []
}

variable "security_group_ids" {
  description = "VPC security group IDs (required when subnet_ids is set)"
  type        = list(string)
  default     = []
}

variable "file_system_config" {
  description = "EFS mount configuration (optional)"
  type = object({
    arn              = string
    local_mount_path = string
  })
  default = null
}

variable "ipv6_allowed_for_dual_stack" {
  description = "Allow IPv6 dual-stack for VPC-attached functions"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Additional tags to apply to the function"
  type        = map(string)
  default     = {}
}
