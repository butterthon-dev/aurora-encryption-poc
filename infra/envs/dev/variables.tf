variable "env" {
  type        = string
  description = "環境名"
}

variable "system" {
  type        = string
  description = "システム名"
}

variable "vpc_cidr_block" {
  type        = string
  description = "VPCのCIDRブロック"
}

variable "private_subnets" {
  type        = map(string)
  description = "プライベートサブネットのマップ（key: AZ, value: CIDR）"
}
