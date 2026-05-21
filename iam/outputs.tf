output "role_arn" {
  description = "ARN of the IAM role"
  value       = var.create_role ? aws_iam_role.this[0].arn : null
}

output "role_name" {
  description = "Name of the IAM role"
  value       = var.create_role ? aws_iam_role.this[0].name : null
}

output "user_arn" {
  description = "ARN of the IAM user"
  value       = var.create_user ? aws_iam_user.this[0].arn : null
}

output "user_name" {
  description = "Name of the IAM user"
  value       = var.create_user ? aws_iam_user.this[0].name : null
}

output "instance_profile_arn" {
  description = "ARN of the instance profile"
  value       = var.create_role && var.create_instance_profile ? aws_iam_instance_profile.this[0].arn : null
}

output "instance_profile_name" {
  description = "Name of the instance profile"
  value       = var.create_role && var.create_instance_profile ? aws_iam_instance_profile.this[0].name : null
}

output "custom_policy_arns" {
  description = "ARNs of created custom policies, keyed by name"
  value       = { for k, v in aws_iam_policy.custom : k => v.arn }
}

output "custom_policy_names" {
  description = "Names of created custom policies"
  value       = { for k, v in aws_iam_policy.custom : k => v.name }
}
