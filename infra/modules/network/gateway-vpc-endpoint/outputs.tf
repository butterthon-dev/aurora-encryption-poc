output "prefix_list_ids" {
  description = "Gateway型VPCエンドポイントのプレフィックスリストID (サービス名をキーにしたマップ)"
  value = {
    s3 = aws_vpc_endpoint.s3.prefix_list_id
  }
}

output "s3_vpc_endpoint_id" {
  description = "S3用VPCエンドポイントのID"
  value       = aws_vpc_endpoint.s3.id
}
