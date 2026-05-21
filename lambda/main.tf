resource "aws_lambda_function" "this" {
  architectures = [var.architecture]

  dynamic "environment" {
    for_each = length(var.environment_variables) > 0 ? [1] : []
    content {
      variables = var.environment_variables
    }
  }

  ephemeral_storage {
    size = var.ephemeral_storage_size
  }

  function_name = var.function_name
  image_uri     = var.image_uri

  logging_config {
    log_format = "Text"
    log_group  = "/aws/lambda/${var.function_name}"
  }

  memory_size                    = var.memory_size
  package_type                   = "Image"
  publish                        = false
  reserved_concurrent_executions = var.reserved_concurrent_executions
  role                           = var.role
  timeout                        = var.timeout
  tags                           = var.tags

  dynamic "vpc_config" {
    for_each = length(var.subnet_ids) > 0 ? [1] : []
    content {
      subnet_ids                  = var.subnet_ids
      security_group_ids          = var.security_group_ids
      ipv6_allowed_for_dual_stack = var.ipv6_allowed_for_dual_stack
    }
  }

  dynamic "file_system_config" {
    for_each = var.file_system_config != null ? [var.file_system_config] : []
    content {
      arn              = file_system_config.value.arn
      local_mount_path = file_system_config.value.local_mount_path
    }
  }

  tracing_config {
    mode = "PassThrough"
  }

  lifecycle {
    # image_uri is ignored — devs push images via CI/CD without going through Terraform.
    # description is set per-deploy by CI/CD pipelines, not managed here.
    ignore_changes = [image_uri, description]
  }
}
