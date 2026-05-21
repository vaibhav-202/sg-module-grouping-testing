resource "aws_eip" "this" {
  for_each = toset([
    for subnet, _ in local.subnets_with_cidr : subnet
    if local.subnets_with_cidr[subnet].config.nat == true
  ])

  network_border_group = data.aws_availability_zones.this.region

  public_ipv4_pool = "amazon"

  tags = {
    Name = "${var.environment}-${each.key}-eip"
  }
}

resource "aws_nat_gateway" "this" {
  for_each = {
    for subnet, _ in local.subnets_with_cidr : subnet => aws_subnet.this[subnet].id
    if local.subnets_with_cidr[subnet].config.nat == true
  }

  connectivity_type = "public"

  subnet_id     = each.value
  allocation_id = aws_eip.this[each.key].id

  tags = {
    Name = "${var.environment}-${each.key}-nat-gateway"
  }
}
