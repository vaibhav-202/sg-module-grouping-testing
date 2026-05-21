resource "aws_vpc" "this" {
  count =0
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
  count = 0
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.environment}-igw"
  }
}
