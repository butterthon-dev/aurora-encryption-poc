module "network" {
  source = "../../stacks/core-network"

  name_prefix     = "${var.env}-${var.system}"
  vpc_cidr_block  = var.vpc_cidr_block
  private_subnets = var.private_subnets
}
