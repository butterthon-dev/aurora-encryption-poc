module "database" {
  source = "../../modules/rds/aurora-mysql"

  name_prefix         = var.name_prefix
  name                = "main"
  engine_version      = "8.0.mysql_aurora.3.08.2"
  availability_zones  = var.availability_zones
  master_username     = "root"
  database_name       = "poc"
  skip_final_snapshot = true # 検証用なのでDBクラスタ削除前のスナップショット作成不要
  vpc_id              = var.vpc_id
  vpc_cidr            = var.vpc_cidr
  subnet_ids          = var.subnet_ids
  storage_encrypted   = var.storage_encrypted

  master_password_wo_version = 2
}


# 踏み台サーバ

module "bastion_role" {
  source = "../../modules/iam/roles/bastion-role"

  name_prefix = var.name_prefix
  role_name   = "bastion"
}

module "bastion_security_group" {
  source = "../../modules/network/security-group"

  name_prefix = "${var.name_prefix}-bastion"
  description = "Security group for bastion"
  vpc_id      = var.vpc_id
}

module "bastion_security_group_egress_rule" {
  source = "../../modules/network/security-group-egress-rule"

  security_group_id = module.bastion_security_group.id
  description       = "Egress rule for bastion"
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = -1
  to_port           = -1
  ip_protocol       = "-1"
}

module "bastion_private" {
  source = "../../modules/ec2"

  name_prefix        = var.name_prefix
  instance_name      = "bastion-private"
  instance_type      = "t2.micro"
  subnet_id          = var.bastion_subnet_id
  security_group_ids = [module.bastion_security_group.id]
  attach_role_name   = module.bastion_role.name
}
