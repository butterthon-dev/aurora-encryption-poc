# importしたリソースを管理外にする（リソースの削除も行わない）
removed {
  from = module.compute.module.database.aws_rds_cluster_parameter_group.this
  lifecycle {
    destroy = false
  }
}

removed {
  from = module.compute.module.database.aws_iam_role.monitoring_role
  lifecycle {
    destroy = false
  }
}

removed {
  from = module.compute.module.database.aws_iam_role_policy_attachment.monitoring_role_policy
  lifecycle {
    destroy = false
  }
}

removed {
  from = module.compute.module.database.aws_security_group.this
  lifecycle {
    destroy = false
  }
}

removed {
  from = module.compute.module.database.aws_secretsmanager_secret.master_password
  lifecycle {
    destroy = false
  }
}

removed {
  from = module.compute.module.database.aws_secretsmanager_secret_version.master_password
  lifecycle {
    destroy = false
  }
}

removed {
  from = module.compute.module.database.aws_ssm_parameter.master_username
  lifecycle {
    destroy = false
  }
}

removed {
  from = module.compute.module.database.aws_ssm_parameter.reader_endpoint
  lifecycle {
    destroy = false
  }
}

removed {
  from = module.compute.module.database.aws_ssm_parameter.writer_endpoint
  lifecycle {
    destroy = false
  }
}

removed {
  from = module.compute.module.database.aws_ssm_parameter.database_name
  lifecycle {
    destroy = false
  }
}
