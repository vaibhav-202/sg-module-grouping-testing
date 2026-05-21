output "schedule_arn" {
  description = "ARN of the EventBridge Scheduler schedule"
  value       = aws_scheduler_schedule.this.arn
}

output "schedule_name" {
  description = "Name of the EventBridge Scheduler schedule"
  value       = aws_scheduler_schedule.this.name
}

output "invoker_role_arn" {
  description = "ARN of the IAM role EventBridge Scheduler uses to invoke the target"
  value       = local.effective_invoker_role_arn
}
