locals {
  name_prefix    = "${var.env}-${var.system}"
  aws_account_id = data.aws_caller_identity.current.account_id
  region         = data.aws_region.current.region
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

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
  bastion_subnet_id  = module.network.private_subnet_ids[0]

  # NOTE:
  #   初回構築時はfalse（2026年2月からfalseでもデフォルト暗号化が適用されるようにはなってしまったので、暗号化を無効化にすることができなくなった）
  #
  #   falseとtrueで暗号化キーに設定されるキーが微妙に異なるため、
  #   スナップショットからの復元後にstorage_encryptedをtrueにしてterraform import（実際はimport block）することで本検証を行う。
  storage_encrypted = false

  snapshot_identifier = "arn:aws:rds:${local.region}:${local.aws_account_id}:cluster-snapshot:dev-poc-cluster-main-20260727"
  kms_key_id          = "arn:aws:kms:${local.region}:${local.aws_account_id}:key/81298318-0e43-471f-bb31-4243af26f5c4" # AWSマネージド型キー「aws/rds」のキーARN
}
