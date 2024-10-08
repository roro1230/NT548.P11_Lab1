# Create the VPC
resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr_block

  tags = var.tags
}

# Create the Internet Gateway
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = var.tags
}

# Create the Public Subnet
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnet_cidr_block
  map_public_ip_on_launch = true  # Assigns public IP automatically

  tags = var.tags
}

# Create the Private Subnet
resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.this.id
  cidr_block = var.private_subnet_cidr_block

  tags = var.tags
}

# Create the Default Security Group
resource "aws_security_group" "default" {
  vpc_id = aws_vpc.this.id

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}
