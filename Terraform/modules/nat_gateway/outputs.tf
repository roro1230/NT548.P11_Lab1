# Output the NAT Gateway ID
output "nat_gateway_id" {
  description = "The ID of the NAT Gateway"
  value       = aws_nat_gateway.nat.id
}

# Output the Elastic IP allocation ID
output "eip_allocation_id" {
  description = "The allocation ID of the Elastic IP for NAT Gateway"
  value       = aws_eip.nat_eip.id
}
