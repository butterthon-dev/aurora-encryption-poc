locals {
  name_prefix = "${var.env}-${var.system}"
}

module "network" {
  source = "../../stacks/core-network"

  name_prefix     = local.name_prefix
  vpc_cidr_block  = var.vpc_cidr_block
  private_subnets = var.private_subnets
}

module "compute" {
  source = "../../stacks/compute"

  name_prefix        = local.name_prefix
  vpc_cidr           = var.vpc_cidr_block
  vpc_id             = module.network.vpc_id
  subnet_ids         = module.network.private_subnet_ids
  availability_zones = ["us-west-2a", "us-west-2c"]

  # NOTE:
  #   初回構築時はfalse（2026年2月からfalseでもデフォルト暗号化が適用されるようにはなってしまったので、暗号化を無効化にすることができなくなった）
  #
  #   falseとtrueで暗号化キーに設定されるキーが微妙に異なるため、
  #   スナップショットからの復元後にstorage_encryptedをtrueにしてterraform import（実際はimport block）することで本検証を行う。
  storage_encrypted = false

  bastion_subnet_id = module.network.private_subnet_ids[0]
}
