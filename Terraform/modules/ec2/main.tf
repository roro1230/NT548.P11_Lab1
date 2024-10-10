# Tự động tìm AMI Amazon Linux 2 từ AWS
data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]  # Lấy AMI từ Amazon
}

# Tạo Public EC2 Instance
resource "aws_instance" "public_instance" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.public_instance_type
  subnet_id     = var.public_subnet_id

  # Security Group cho Public Instance
  vpc_security_group_ids = [aws_security_group.public_sg.id]

  # Gán Public IP để có thể truy cập từ Internet
  associate_public_ip_address = true

  tags = var.tags
}

# Tạo Private EC2 Instance
resource "aws_instance" "private_instance" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.private_instance_type
  subnet_id     = var.private_subnet_id

  # Security Group cho Private Instance
  vpc_security_group_ids = [aws_security_group.private_sg.id]

  # Không có Public IP, chỉ truy cập từ Public instance
  associate_public_ip_address = false

  tags = var.tags
}

# Security Group cho Public EC2 Instance
resource "aws_security_group" "public_sg" {
  vpc_id = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Cho phép SSH từ bất kỳ đâu
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
