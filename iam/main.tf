resource "aws_iam_role" "this" {
  count = var.create_role ? 1 : 0

  name               = var.role_name
  assume_role_policy = var.trust_policy
  tags               = var.additional_tags
}

resource "aws_iam_user" "this" {
  count = var.create_user ? 1 : 0

  name = var.user_name
  tags = var.additional_tags
}

resource "aws_iam_instance_profile" "this" {
  count = var.create_role && var.create_instance_profile ? 1 : 0

  name = "${aws_iam_role.this[0].name}-profile"
  role = aws_iam_role.this[0].name
  tags = var.additional_tags
}

resource "aws_iam_policy" "custom" {
  for_each = { for p in var.custom_policies : p.name => p }

  name        = each.value.name
  description = each.value.description
  policy      = each.value.policy
  tags        = var.additional_tags
}

resource "aws_iam_role_policy_attachment" "managed_role" {
  for_each = var.create_role ? toset(concat(var.managed_policy_arns, var.role_managed_policy_arns)) : toset([])

  role       = aws_iam_role.this[0].name
  policy_arn = each.value
}

resource "aws_iam_role_policy_attachment" "custom_role" {
  for_each = var.create_role ? aws_iam_policy.custom : {}

  role       = aws_iam_role.this[0].name
  policy_arn = each.value.arn
}

resource "aws_iam_user_policy_attachment" "managed_user" {
  for_each = var.create_user ? toset(concat(var.managed_policy_arns, var.user_managed_policy_arns)) : toset([])

  user       = aws_iam_user.this[0].name
  policy_arn = each.value
}

resource "aws_iam_user_policy_attachment" "custom_user" {
  for_each = var.create_user ? aws_iam_policy.custom : {}

  user       = aws_iam_user.this[0].name
  policy_arn = each.value.arn
}
