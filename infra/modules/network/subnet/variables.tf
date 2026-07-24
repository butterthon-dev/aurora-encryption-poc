variable "name_prefix" {
  type        = string
  description = "サブネット名の接頭辞"
}

variable "vpc_id" {
  type        = string
  description = "VPCのID"
}

variable "cidr_block" {
  type        = string
  description = "サブネットのCIDRブロック"
}

variable "availability_zone" {
  type        = string
  description = "サブネットの可用性ゾーン"
}
