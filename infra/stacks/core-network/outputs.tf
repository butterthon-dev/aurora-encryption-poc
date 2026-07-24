output "vpc_id" {
  description = "VPCのID"
  value       = module.vpc.id
}

output "private_subnet_ids" {
  description = "プライベートサブネットのIDリスト"
  value       = [for private_subnet in module.private_subnets : private_subnet.id]
}
