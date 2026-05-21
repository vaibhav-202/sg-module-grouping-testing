data "aws_availability_zones" "this" {
  state = "available"
}

resource "aws_subnet" "this" {
  for_each = local.subnets_with_cidr

  vpc_id     = aws_vpc.this.id
  cidr_block = each.value.cidr
  availability_zone = "${data.aws_availability_zones.this.region}${each.value.az}"

  map_public_ip_on_launch             = each.value.config.public
  private_dns_hostname_type_on_launch = "ip-name"

  assign_ipv6_address_on_creation                = false
  enable_dns64                                   = false
  enable_resource_name_dns_a_record_on_launch    = false
  enable_resource_name_dns_aaaa_record_on_launch = false
  ipv6_native                                    = false
}
