# サブネットグループは新旧クラスタで物理的に分けても問題ないのでimportしない
# import {
#   identity = {
#     name = "..."
#   }
#   to = module.compute.module.database_v2.aws_db_subnet_group.this
# }

import {
  id = "aurora-parameter-group-v1"
  to = module.compute.module.database_v2.aws_rds_cluster_parameter_group.this
}

import {
  identity = {
    name = "dev-poc-role-main-monitoring"
  }
  to = module.compute.module.database_v2.aws_iam_role.monitoring_role
}

import {
  identity = {
    role       = "dev-poc-role-main-monitoring"
    policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
  }
  to = module.compute.module.database_v2.aws_iam_role_policy_attachment.monitoring_role_policy
}

import {
  identity = {
    id = "sg-0ab714f882c161ae5"
  }
  to = module.compute.module.database_v2.aws_security_group.this
}

import {
  identity = {
    "arn" = "arn:aws:secretsmanager:${local.region}:${local.aws_account_id}:secret:dev-poc-sms-master_password-gDYEuo"
  }
  to = module.compute.module.database_v2.aws_secretsmanager_secret.master_password
}

import {
  identity = {
    secret_id  = "arn:aws:secretsmanager:${local.region}:${local.aws_account_id}:secret:dev-poc-sms-master_password-gDYEuo"
    version_id = "terraform-qk3cWZrMM6jOSAoxJppeS4oKxb"
  }
  to = module.compute.module.database_v2.aws_secretsmanager_secret_version.master_password
}

# CloudWatchロググループは新旧クラスタで物理的に分けた方が良さそうなのでimportしない
# import {
#   identity = {
#     name = "/aws/rds/instance/dev-poc-cluster-main/error"
#   }
#   to = module.compute.module.database_v2.aws_cloudwatch_log_group.error
# }

import {
  identity = {
    name = "dev-poc-param-master_username"
  }
  to = module.compute.module.database_v2.aws_ssm_parameter.master_username
}

import {
  identity = {
    name = "dev-poc-param-rds_reader_endpoint"
  }
  to = module.compute.module.database_v2.aws_ssm_parameter.reader_endpoint
}

import {
  identity = {
    name = "dev-poc-param-rds_writer_endpoint"
  }
  to = module.compute.module.database_v2.aws_ssm_parameter.writer_endpoint
}

import {
  identity = {
    name = "dev-poc-param-rds_database_name"
  }
  to = module.compute.module.database_v2.aws_ssm_parameter.database_name
}
