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
