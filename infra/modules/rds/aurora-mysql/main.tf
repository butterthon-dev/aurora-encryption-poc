locals {
  master_password = ephemeral.random_password.master_password.result
}

# DBサブネットグループ
resource "aws_db_subnet_group" "this" {
  description = "${var.name_prefix}-subnetg-${var.name}"
  subnet_ids  = var.subnet_ids
}

resource "aws_rds_cluster_parameter_group" "this" {
  name        = var.parameter_group_name
  family      = var.parameter_group_family
  description = "aurora parameter group"

  parameter {
    name         = "character_set_client"
    value        = "utf8mb4"
    apply_method = "pending-reboot"
  }

  parameter {
    name         = "character_set_connection"
    value        = "utf8mb4"
    apply_method = "pending-reboot"
  }

  parameter {
    name         = "character_set_database"
    value        = "utf8mb4"
    apply_method = "pending-reboot"
  }

  parameter {
    name         = "character_set_server"
    value        = "utf8mb4"
    apply_method = "pending-reboot"
  }

  parameter {
    name         = "time_zone"
    value        = "Asia/Tokyo"
    apply_method = "pending-reboot"
  }

  parameter {
    name         = "binlog_format"
    value        = "MIXED"
    apply_method = "pending-reboot"
  }

  dynamic "parameter" {
    for_each = var.additional_cluster_parameters
    content {
      name         = parameter.value.name
      value        = parameter.value.value
      apply_method = parameter.value.apply_method
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}


# RDS が拡張モニタリングメトリクスをCloudWatch Logsに送信することを許可するIAMロール。
resource "aws_iam_role" "monitoring_role" {
  name = "${var.name_prefix}-role-main-monitoring"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "monitoring.rds.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "monitoring_role_policy" {
  role       = aws_iam_role.monitoring_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}


# セキュリティグループ
resource "aws_security_group" "this" {
  vpc_id      = var.vpc_id
  name        = "${var.name_prefix}-sg-cluster-main"
  description = "MySQL db security group"

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}


# マスターパスワード
resource "aws_secretsmanager_secret" "master_password" {
  name = "${var.name_prefix}-sms-master_password"
}

resource "aws_secretsmanager_secret_version" "master_password" {
  secret_id                = aws_secretsmanager_secret.master_password.id
  secret_string_wo         = local.master_password
  secret_string_wo_version = var.master_password_wo_version # パスワードがtfstateに保存されないようにwrite-only引数を使用
}

ephemeral "random_password" "master_password" {
  length           = 32
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}


# クラスタ
resource "aws_rds_cluster" "this" {
  cluster_identifier              = "${var.name_prefix}-cluster-${var.name}"
  engine                          = "aurora-mysql"
  engine_version                  = var.engine_version
  availability_zones              = var.availability_zones
  database_name                   = var.database_name
  master_username                 = var.master_username
  master_password_wo              = local.master_password # パスワードがtfstateに保存されないようにwrite-only引数を使用
  master_password_wo_version      = var.master_password_wo_version
  enabled_cloudwatch_logs_exports = ["audit", "error", "slowquery"]
  engine_mode                     = "provisioned" # サーバー常時稼働
  vpc_security_group_ids          = [aws_security_group.this.id]
  db_subnet_group_name            = aws_db_subnet_group.this.name
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.this.name
  skip_final_snapshot             = var.skip_final_snapshot
  final_snapshot_identifier       = var.final_snapshot_identifier
  apply_immediately               = var.apply_immediately
  storage_encrypted               = var.storage_encrypted
  snapshot_identifier             = var.snapshot_identifier
  kms_key_id                      = var.kms_key_id

  lifecycle {
    ignore_changes = [
      availability_zones,
      engine_version,
      snapshot_identifier,
    ]
  }
}


# インスタンス
resource "aws_rds_cluster_instance" "writer_instance" {
  identifier                            = "${aws_rds_cluster.this.cluster_identifier}-0"
  cluster_identifier                    = aws_rds_cluster.this.id
  instance_class                        = var.instance_class
  engine                                = "aurora-mysql"
  engine_version                        = var.engine_version
  publicly_accessible                   = false
  monitoring_interval                   = 60
  monitoring_role_arn                   = aws_iam_role.monitoring_role.arn
  performance_insights_enabled          = true
  performance_insights_retention_period = 7
  apply_immediately                     = var.apply_immediately
  promotion_tier                        = 0

  lifecycle {
    ignore_changes = [engine_version]
  }
}


# CloudWatchロググループ
resource "aws_cloudwatch_log_group" "error" {
  name = "/aws/rds/instance/${aws_rds_cluster.this.cluster_identifier}/error"
}


# アプリ向けのパラメータストア
resource "aws_ssm_parameter" "master_username" {
  name  = "${var.name_prefix}-param-master_username"
  type  = "String"
  value = aws_rds_cluster.this.master_username
}

resource "aws_ssm_parameter" "reader_endpoint" {
  name  = "${var.name_prefix}-param-rds_reader_endpoint"
  type  = "String"
  value = aws_rds_cluster.this.reader_endpoint
}

resource "aws_ssm_parameter" "writer_endpoint" {
  name  = "${var.name_prefix}-param-rds_writer_endpoint"
  type  = "String"
  value = aws_rds_cluster.this.endpoint
}

resource "aws_ssm_parameter" "database_name" {
  name  = "${var.name_prefix}-param-rds_database_name"
  type  = "String"
  value = aws_rds_cluster.this.database_name
}
