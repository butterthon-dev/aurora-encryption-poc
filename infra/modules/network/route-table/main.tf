resource "aws_route_table" "this" {
  vpc_id = var.vpc_id

  dynamic "route" {
    for_each = toset(var.routes)

    content {
      cidr_block     = route.value.cidr_block
      gateway_id     = route.value.gateway_id
      nat_gateway_id = route.value.nat_gateway_id
    }
  }

  tags = {
    Name = "${var.name_prefix}-rtb"
  }
}

resource "aws_route_table_association" "this" {
  for_each = { for idx, subnet_id in var.association_subnet_ids : idx => subnet_id }

  route_table_id = aws_route_table.this.id
  subnet_id      = each.value
}
