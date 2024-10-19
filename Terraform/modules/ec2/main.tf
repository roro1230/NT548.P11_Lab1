# Tự động tìm AMI Amazon Linux 2 mới nhất
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
  vpc_security_group_ids = [var.public_sg_id]

  # Gán Public IP để có thể truy cập từ Internet
  associate_public_ip_address = true

  key_name = var.key_name  # This is the name of the key pair

  tags = var.tags
}

# Tạo Private EC2 Instance
resource "aws_instance" "private_instance" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.private_instance_type
  subnet_id     = var.private_subnet_id

  # Security Group cho Private Instance
  vpc_security_group_ids = [var.private_sg_id]

  # Không có Public IP, chỉ truy cập từ Public instance
  associate_public_ip_address = false

  key_name = var.key_name

  tags = var.tags
}
