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

# Module EC2
module "ec2" {
  source = "./modules/ec2"

  public_instance_type  = "t2.micro"  # Loại EC2 instance cho Public Instance
  private_instance_type = "t2.micro"  # Loại EC2 instance cho Private Instance
  public_subnet_id      = module.vpc.public_subnet_id  # Lấy từ VPC module
  private_subnet_id     = module.vpc.private_subnet_id  # Lấy từ VPC module
  vpc_id                = module.vpc.vpc_id  # Lấy từ VPC module

  tags = {
    Name = "EC2 Instances"
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
