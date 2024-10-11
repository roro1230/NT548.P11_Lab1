# Security Group cho Public EC2 Instance
resource "aws_security_group" "public_sg" {
  vpc_id = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ssh_ip]  # Sử dụng biến allowed_ssh_ip
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Cho phép tất cả lưu lượng ra ngoài
  }

  tags = var.tags
}

# Security Group cho Private EC2 Instance
resource "aws_security_group" "private_sg" {
  vpc_id = var.vpc_id

  # Chỉ cho phép SSH từ Security Group của Public instance
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [aws_security_group.public_sg.id]  # Chỉ cho phép truy cập từ Public SG
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Cho phép tất cả lưu lượng ra ngoài
  }

  tags = var.tags
}
