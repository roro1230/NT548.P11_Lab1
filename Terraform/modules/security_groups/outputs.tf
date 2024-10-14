# Xuất ID của Public Security Group
output "public_sg_id" {
  description = "ID of the Public Security Group"
  value       = aws_security_group.public_sg.id
}

# Xuất ID của Private Security Group
output "private_sg_id" {
  description = "ID of the Private Security Group"
  value       = aws_security_group.private_sg.id
}
