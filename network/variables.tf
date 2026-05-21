variable "environment" {
  description = "Environment name (e.g., dev, prod)"
  type        = string
}

variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "subnets" {
  description = "Subnet configuration map organized by subnet type and availability zone. CIDR blocks are automatically assigned sequentially."
  type = map(map(object({
    public    = bool
    nat       = optional(bool, false)
    route_nat = optional(bool, false)
    igw       = optional(bool, false)
  })))
}

variable "default_network_acl" {
  type = object({
    egress = list(object({
      action          = string
      cidr_block      = optional(string)
      from_port       = number
      icmp_code       = optional(number)
      icmp_type       = optional(number)
      ipv6_cidr_block = optional(string)
      protocol        = string
      rule_no         = number
      to_port         = number
    }))
    ingress = list(object({
      action          = string
      cidr_block      = optional(string)
      from_port       = number
      icmp_code       = optional(number)
      icmp_type       = optional(number)
      ipv6_cidr_block = optional(string)
      protocol        = string
      rule_no         = number
      to_port         = number
    }))
  })
  default = {
    egress = [
      {
        action     = "allow"
        cidr_block = "0.0.0.0/0"
        from_port  = "0"
        icmp_code  = "0"
        icmp_type  = "0"
        protocol   = "-1"
        rule_no    = "100"
        to_port    = "0"
      },
      {
        action          = "allow"
        from_port       = "0"
        icmp_code       = "0"
        icmp_type       = "0"
        ipv6_cidr_block = "::/0"
        protocol        = "-1"
        rule_no         = "101"
        to_port         = "0"
      }
    ],
    ingress = [
      {
        action     = "allow"
        cidr_block = "0.0.0.0/0"
        from_port  = "0"
        icmp_code  = "0"
        icmp_type  = "0"
        protocol   = "-1"
        rule_no    = "100"
        to_port    = "0"
      },
      {
        action          = "allow"
        from_port       = "0"
        icmp_code       = "0"
        icmp_type       = "0"
        ipv6_cidr_block = "::/0"
        protocol        = "-1"
        rule_no         = "101"
        to_port         = "0"
      }
    ]
  }
}
