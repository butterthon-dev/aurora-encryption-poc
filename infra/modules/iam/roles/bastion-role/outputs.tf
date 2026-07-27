output "arn" {
  description = "IAMロールARN"
  value       = aws_iam_role.this.arn
}

output "name" {
  description = "IAMロール名"
  value       = aws_iam_role.this.name
}
