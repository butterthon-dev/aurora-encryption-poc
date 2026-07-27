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
}
