output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.this.id
}

output "subnet_ids" {
  description = "Subnet IDs"
  value = {
    for subnet, azs in var.subnets : subnet => [
      for az, config in azs : aws_subnet.this["${subnet}-${az}"].id
    ]
  }
}

output "subnet_cidrs" {
  description = ""
  value = {
    for subnet, azs in var.subnets : subnet => {
      for az, config in azs : az => aws_subnet.this["${subnet}-${az}"].cidr_block
    }
  }
}

output "nat_gateway_ids" {
  description = "NAT Gateway IDs"
  value       = [for natgw in aws_nat_gateway.this : natgw.id]
}

output "internet_gateway_id" {
  description = "Internet Gateway ID"
  value       = aws_internet_gateway.this.id
}
