# Output the VPC ID
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

# Output the Public Subnet ID
output "public_subnet_id" {
  description = "The ID of the public subnet"
  value       = module.vpc.public_subnet_id
}

# Output the Private Subnet ID
output "private_subnet_id" {
  description = "The ID of the private subnet"
  value       = module.vpc.private_subnet_id
}

# Output the Internet Gateway ID
output "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  value       = module.vpc.internet_gateway_id
}

# Output the Default Security Group ID
output "default_security_group_id" {
  description = "The ID of the default security group"
  value       = module.vpc.default_security_group_id
}

# Output the NAT Gateway ID
output "nat_gateway_id" {
  description = "The ID of the NAT Gateway"
  value       = module.nat_gateway.nat_gateway_id
}

# Output the Elastic IP allocation ID
output "eip_allocation_id" {
  description = "The allocation ID of the Elastic IP for NAT Gateway"
  value       = module.nat_gateway.eip_allocation_id
}

# Output the Public Route Table ID
output "public_route_table_id" {
  description = "The ID of the public route table"
  value       = module.route_table.public_route_table_id
}

# Output the Private Route Table ID
output "private_route_table_id" {
  description = "The ID of the private route table"
  value       = module.route_table.private_route_table_id
}
