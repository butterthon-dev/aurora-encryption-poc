variable "name_prefix" {
  description = "ルートテーブル名の接頭辞"
  type        = string
}

variable "vpc_id" {
  description = "ルートテーブルが属するVPCのID"
  type        = string
}

variable "routes" {
  description = "ルートテーブルのルート"
  type = list(object({
    cidr_block     = string
    gateway_id     = optional(string)
    nat_gateway_id = optional(string)
  }))
  default = []
}

variable "association_subnet_ids" {
  description = "ルートテーブルに関連付けるサブネットのID"
  type        = list(string)
  default     = []
}
