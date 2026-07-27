variable "name_prefix" {
  type        = string
  description = "EC2インスタンス名の接頭辞"
}

variable "instance_name" {
  type        = string
  description = "EC2インスタンス名"
}

variable "instance_type" {
  type        = string
  description = "EC2インスタンスタイプ"
  default     = "t2.micro"
}

variable "subnet_id" {
  type        = string
  description = "サブネットID"
}

variable "security_group_ids" {
  type        = list(string)
  description = "セキュリティグループID"
}

variable "attach_role_name" {
  type        = string
  description = "IAMロール名"
}
