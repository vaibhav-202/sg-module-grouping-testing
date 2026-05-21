locals {
  total_subnets = sum([
    for subnet_type, azs in var.subnets : length(azs)
  ])

  subnet_cidrs = [
    for i in range(0, local.total_subnets) : cidrsubnet(var.cidr_block, 8, i)
  ]

  subnet_keys = sort(flatten([
    for subnet, azs in var.subnets : [
      for az, _ in azs : "${subnet}-${az}"
    ]
  ]))

  subnets_with_cidr = {
    for idx, key in local.subnet_keys : key => {
      cidr = local.subnet_cidrs[idx]
      config = lookup(
        lookup(var.subnets, split("-", key)[0]),
        split("-", key)[1]
      )
      type = split("-", key)[0]
      az   = split("-", key)[1]
    }
  }

  nat_route_table_subnets = {
    for subnet, _ in local.subnets_with_cidr :
    subnet => aws_nat_gateway.this[
      one([
        for k in keys(aws_nat_gateway.this) : k
        if endswith(k, "-${split("-", subnet)[1]}")
      ])
    ].id
    if local.subnets_with_cidr[subnet].config.route_nat == true
  }

  igw_route_table_subnets = {
    for subnet, _ in local.subnets_with_cidr :
    subnet => aws_subnet.this[subnet].id
    if local.subnets_with_cidr[subnet].config.igw == true
  }

  other_route_table_subnets = setsubtract(
    toset([
      for subnet, _ in local.subnets_with_cidr : subnet
      if local.subnets_with_cidr[subnet].config.public == false
    ]),
    toset(concat(
      keys(aws_route_table.nat),
      keys(local.igw_route_table_subnets)
    ))
  )
}
