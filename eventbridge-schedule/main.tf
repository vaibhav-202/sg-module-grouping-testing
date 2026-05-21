locals {
  effective_invoker_role_arn = var.invoker_role_arn != "" ? var.invoker_role_arn : module.invoker_role[0].role_arn
}

module "invoker_role" {
  source = "../iam"
  count  = var.invoker_role_arn == "" ? 1 : 0

  create_role = true
  role_name   = "${var.rule_name}-invoker"

  trust_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "scheduler.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })

  custom_policies = [{
    name        = "${var.rule_name}-invoke"
    description = "Allow EventBridge Scheduler to invoke ${var.target_arn}"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [{
        Effect   = "Allow"
        Action   = "lambda:InvokeFunction"
        Resource = var.target_arn
      }]
    })
  }]

  additional_tags = var.tags
}

resource "aws_scheduler_schedule" "this" {
  name                         = var.rule_name
  schedule_expression          = var.schedule_expression
  schedule_expression_timezone = var.schedule_expression_timezone

  flexible_time_window { mode = "OFF" }

  target {
    arn      = var.target_arn
    role_arn = local.effective_invoker_role_arn
    input    = var.target_input_json
  }
}
