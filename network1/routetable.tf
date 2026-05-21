/*-------------+
 | NAT Gateway |
 +-------------*/
resource "aws_route_table" "nat" {
  for_each = local.nat_route_table_subnets

  vpc_id = aws_vpc.this.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = each.value
  }

  tags = {
    Name = "${var.environment}-nat-${each.key}"
  }
}

resource "aws_route_table_association" "nat" {
  for_each = aws_route_table.nat

  route_table_id = each.value.id
  subnet_id      = aws_subnet.this[each.key].id
}

/*------------------+
 | Internet Gateway |
 +------------------*/
resource "aws_route_table" "igw" {
  for_each = local.igw_route_table_subnets

  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    Name = "${var.environment}-igw-${each.key}"
  }
}

resource "aws_route_table_association" "igw" {
  for_each = aws_route_table.igw

  route_table_id = each.value.id
  subnet_id      = aws_subnet.this[each.key].id
}

/*-------+
 | Other |
 +-------*/
resource "aws_route_table" "other" {
  for_each = local.other_route_table_subnets

  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.environment}-other-${each.key}"
  }
}

resource "aws_route_table_association" "other" {
  for_each = aws_route_table.other

  route_table_id = each.value.id
  subnet_id      = aws_subnet.this[each.key].id
}
