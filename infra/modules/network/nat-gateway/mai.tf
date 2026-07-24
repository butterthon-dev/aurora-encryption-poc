resource "aws_nat_gateway" "this" {
  vpc_id            = var.vpc_id
  availability_mode = "regional"
  connectivity_type = "public"

  tags = {
    Name = "${var.name_prefix}-nat-gateway"
  }
}
