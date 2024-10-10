# Xuất ra Public Instance ID
output "public_instance_id" {
  description = "The ID of the public EC2 instance"
  value       = aws_instance.public_instance.id
}

# Xuất ra Private Instance ID
output "private_instance_id" {
  description = "The ID of the private EC2 instance"
  value       = aws_instance.private_instance.id
}

# Xuất ra Public IP của Public Instance
output "public_instance_public_ip" {
  description = "The public IP of the public EC2 instance"
  value       = aws_instance.public_instance.public_ip
}

# Xuất ra Private IP của Private Instance
output "private_instance_private_ip" {
  description = "The private IP of the private EC2 instance"
  value       = aws_instance.private_instance.private_ip
}
