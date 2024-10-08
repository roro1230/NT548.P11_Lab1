resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  
  tags = {
    Name = "my-vpc"
  }
}
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true  # Tự động gán IP public cho các tài nguyên trong Public Subnet
  
  tags = {
    Name = "public-subnet"
  }
}
resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.2.0/24"
  
  tags = {
    Name = "private-subnet"
  }
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id
  
  tags = {
    Name = "my-igw"
  }
}
resource "aws_eip" "nat_eip" {
  vpc = true
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public.id
  
  tags = {
    Name = "my-nat-gateway"
  }
}
resource "aws_security_group" "default" {
  vpc_id = aws_vpc.my_vpc.id
  
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

  tags = {
    Name = "default-sg"
  }
}

#import the route_modules
module "route_table" {
  source = "./modules/route_table"

  vpc_id              = aws_vpc.my_vpc.id
  public_subnet_id    = aws_subnet.public.id
  private_subnet_id   = aws_subnet.private.id
  internet_gateway_id = aws_internet_gateway.igw.id
  nat_gateway_id      = aws_nat_gateway.nat.id

  tags = {
    Name = "my-route-table"
  }
}
