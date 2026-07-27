variable "name_prefix" {
  type        = string
  description = "クラスタリソース名のプレフィックス"
}

variable "name" {
  type        = string
  description = "クラスタ名"
}

variable "engine_version" {
  type        = string
  description = "データベースエンジンバージョン"
}

variable "availability_zones" {
  type        = list(string)
  description = "AZ"
}

variable "database_name" {
  type        = string
  description = "データベース名"
}

variable "master_username" {
  type        = string
  description = "マスターユーザー名"
}

variable "master_password_wo_version" {
  type        = number
  description = "マスターユーザーのパスワードバージョン（値を変えるとパスワードが更新される）"
  default     = 1
}

variable "parameter_group_name" {
  description = "The name of the DB parameter group"
  type        = string
  default     = "aurora-parameter-group-v1"
}

variable "parameter_group_family" {
  description = "The family of the DB parameter group"
  type        = string
  default     = "aurora-mysql8.0"
}

variable "vpc_id" {
  description = "VPCリソースID"
  type        = string
}

variable "vpc_cidr" {
  description = "VPCのCIDR"
  type        = string
}

variable "subnet_ids" {
  description = "サブネットIDのリスト"
  type        = list(string)
}

variable "additional_cluster_parameters" {
  description = "追加のクラスタパラメータ"
  type = list(object({
    name         = string
    value        = string
    apply_method = optional(string, "immediate")
  }))
  default = []

  validation {
    condition     = alltrue([for p in var.additional_cluster_parameters : contains(["immediate", "pending-reboot"], p.apply_method)])
    error_message = "apply_methodは \"immediate\" または \"pending-reboot\" のみ指定可能です。"
  }

  validation {
    condition     = alltrue([for p in var.additional_cluster_parameters : length(p.name) > 0])
    error_message = "nameは空文字列を指定できません。"
  }
}

variable "skip_final_snapshot" {
  description = <<EOT
  DBクラスタを削除する前の最終的なDBスナップショットをスキップするかどうかを指定。
  falseを指定した場合、DBクラスタが削除される前に、final_snapshot_identifierの値を使用してDBスナップショットが作成される。
  EOT
  type        = bool
  default     = false
}

variable "final_snapshot_identifier" {
  description = <<EOT
  DBクラスタが削除された際の最終DBスナップショット名。
  skip_final_snapshotがfalseの状態でクラスタを削除しようとするとエラーになるので、エラーになった後か、クラスタ削除前に指定する。
  EOT
  type        = string
  default     = null
}

variable "apply_immediately" {
  description = "クラスタの変更を直ちに適用するかどうか。デフォルトはfalse"
  type        = bool
  default     = false
}

variable "instance_class" {
  description = "インスタンスクラス"
  type        = string
  default     = "db.t4g.medium"
}

variable "storage_encrypted" {
  type        = bool
  description = "DBクラスタの暗号化を有効化するかどうか"
  default     = false
}
