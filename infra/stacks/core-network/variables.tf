variable "name_prefix" {
  type        = string
  description = "ネットワーク関連リソース名の接頭辞"
}

variable "vpc_cidr_block" {
  type        = string
  description = "VPCのCIDRブロック"
}

variable "private_subnets" {
  type        = map(string)
  description = "プライベートサブネットのマップ（key: AZ, value: CIDR）"
}
