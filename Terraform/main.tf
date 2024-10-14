provider "aws" {
  region = "us-east-1"  # Ensure this is the region where 'key-15' was created
}

# Module VPC
module "vpc" {
  source = "./modules/vpc"

  vpc_cidr_block            = "10.0.0.0/16"
  public_subnet_cidr_block  = "10.0.1.0/24"
  private_subnet_cidr_block = "10.0.2.0/24"

  tags = {
    Name = "my-vpc"
  }
}

# Module NAT Gateway
module "nat_gateway" {
  source = "./modules/nat_gateway"

  public_subnet_id = module.vpc.public_subnet_id

  tags = {
    Name = "my-nat-gateway"
  }
}

# Module Route Table
module "route_table" {
  source = "./modules/route_table"

  vpc_id              = module.vpc.vpc_id
  public_subnet_id    = module.vpc.public_subnet_id
  private_subnet_id   = module.vpc.private_subnet_id
  internet_gateway_id = module.vpc.internet_gateway_id
  nat_gateway_id      = module.nat_gateway.nat_gateway_id

  tags = {
    Name = "my-route-table"
  }
}
# Gọi module Security Groups
module "security_groups" {
  source  = "./modules/security_groups"
  vpc_id  = module.vpc.vpc_id  # Nhận giá trị từ module VPC
  tags    = {
    Name = "MySecurityGroups"
  }
<<<<<<< HEAD
  allowed_ssh_ip = "14.169.1.248/32" # Thay thế bằng IP cụ thể
=======
  allowed_ssh_ip = "113.161.91.132/32" # Thay thế bằng IP cụ thể
>>>>>>> 6b472a36cfdc8d67ee66fdab25dd1685e6dab1b1
}

# Gọi module EC2
module "ec2" {
  source            = "./modules/ec2"
  vpc_id            = module.vpc.vpc_id
  public_subnet_id  = module.vpc.public_subnet_id
  private_subnet_id = module.vpc.private_subnet_id

  # Truyền Security Group IDs từ module Security Groups
  public_sg_id      = module.security_groups.public_sg_id
  private_sg_id     = module.security_groups.private_sg_id

  public_instance_type  = "t2.micro"
  private_instance_type = "t2.micro"
<<<<<<< HEAD

  key_name = "key-15"

=======
  key_pair_name           = "testing1"
>>>>>>> 6b472a36cfdc8d67ee66fdab25dd1685e6dab1b1
  tags = {
    Name = "MyEC2Instances"
  }
}
# Xuất các output từ module EC2
output "public_instance_id" {
  value = module.ec2.public_instance_id
}

output "private_instance_id" {
  value = module.ec2.private_instance_id
}

output "public_instance_public_ip" {
  value = module.ec2.public_instance_public_ip
}

output "private_instance_private_ip" {
  value = module.ec2.private_instance_private_ip
}