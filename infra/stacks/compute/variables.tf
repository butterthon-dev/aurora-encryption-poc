variable "name_prefix" {
  type        = string
  description = "ネットワーク関連リソース名の接頭辞"
}

variable "availability_zones" {
  type        = list(string)
  description = "AZ"
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

variable "storage_encrypted" {
  type        = bool
  description = "DBクラスタの暗号化を有効化するかどうか"
  default     = true
}

variable "bastion_subnet_id" {
  type        = string
  description = "踏み台サーバ配置先のサブネットID"
}

variable "snapshot_identifier" {
  type        = string
  description = "このクラスターをスナップショットから作成するかどうかを指定する。DBクラスターのスナップショットを指定する場合は名前またはARNのいずれかを使用でき、DBスナップショットを指定する場合はARNを使用する。"
  default     = null
}

variable "kms_key_id" {
  type        = string
  description = "DBクラスタの暗号化に使用するKMSキーのARN。未暗号化スナップショットからの復元時は指定必須。"
  default     = null
}
