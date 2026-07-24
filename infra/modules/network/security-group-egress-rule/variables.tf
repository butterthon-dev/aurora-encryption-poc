variable "security_group_id" {
  description = "対象のセキュリティグループID"
  type        = string
}

variable "description" {
  description = "ルールの説明"
  type        = string
  default     = null
}

variable "cidr_ipv4" {
  description = "許可するCIDR (IPv4)"
  type        = string
  default     = null
}

variable "prefix_list_id" {
  description = "許可するプレフィックスリストID"
  type        = string
  default     = null
}

variable "referenced_security_group_id" {
  description = "許可するセキュリティグループID"
  type        = string
  default     = null
}

variable "from_port" {
  description = "開始ポート"
  type        = number
}

variable "to_port" {
  description = "終了ポート"
  type        = number
}

variable "ip_protocol" {
  description = "IPプロトコル (tcp / udp / icmp / -1 など)"
  type        = string
}
