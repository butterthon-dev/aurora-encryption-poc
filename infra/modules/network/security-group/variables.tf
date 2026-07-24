variable "name_prefix" {
  type        = string
  description = "セキュリティグループ名の接頭辞"
}

variable "description" {
  type        = string
  description = "セキュリティグループの説明"
}

variable "vpc_id" {
  type        = string
  description = "VPCのID"
}
