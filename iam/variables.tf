variable "create_role" {
  description = "Whether to create an IAM role"
  type        = bool
  default     = false
}

variable "role_name" {
  description = "Name of the IAM role"
  type        = string
  default     = ""
}

variable "trust_policy" {
  description = "Assume-role trust policy JSON"
  type        = string
  default     = ""
}

variable "create_user" {
  description = "Whether to create an IAM user"
  type        = bool
  default     = false
}

variable "user_name" {
  description = "Name of the IAM user"
  type        = string
  default     = ""
}

variable "create_instance_profile" {
  description = "Whether to create an EC2 instance profile backed by the role"
  type        = bool
  default     = false
}

variable "custom_policies" {
  description = "Inline policies to create and attach (name, description, policy JSON)"
  type = list(object({
    name        = string
    description = string
    policy      = string
  }))
  default = []
}

variable "managed_policy_arns" {
  description = "Managed policy ARNs to attach to both role and user"
  type        = list(string)
  default     = []
}

variable "role_managed_policy_arns" {
  description = "Managed policy ARNs to attach specifically to the role"
  type        = list(string)
  default     = []
}

variable "user_managed_policy_arns" {
  description = "Managed policy ARNs to attach specifically to the user"
  type        = list(string)
  default     = []
}

variable "additional_tags" {
  description = "Additional tags to apply to created resources"
  type        = map(string)
  default     = {}
}
