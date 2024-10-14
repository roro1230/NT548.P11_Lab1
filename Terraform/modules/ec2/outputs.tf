# Xuất ID của Public EC2 Instance
output "public_instance_id" {
  description = "ID of the Public EC2 Instance"
  value       = aws_instance.public_instance.id
}

# Xuất Public IP của Public EC2 Instance
output "public_instance_public_ip" {
  description = "Public IP of the Public EC2 Instance"
  value       = aws_instance.public_instance.public_ip
}

# Xuất ID của Private EC2 Instance
output "private_instance_id" {
  description = "ID of the Private EC2 Instance"
  value       = aws_instance.private_instance.id
}

# Xuất Private IP của Private EC2 Instance
output "private_instance_private_ip" {
  description = "Private IP of the Private EC2 Instance"
  value       = aws_instance.private_instance.private_ip
}
