resource "aws_vpc" "this" {
  count      = var.create_vpc ? 1 : 0
  cidr_block = var.cidr_block

  instance_tenancy                 = "default"
  assign_generated_ipv6_cidr_block = "false"

  enable_dns_hostnames                 = "true"
  enable_dns_support                   = "true"
  enable_network_address_usage_metrics = "false"

  tags = {
    Name = "${var.environment}-vpc"
  }
}

resource "aws_internet_gateway" "this" {
  count  = var.create_igw ? 1 : 0
  vpc_id = aws_vpc.this[0].id

  tags = {
    Name = "${var.environment}-igw"
  }
}
