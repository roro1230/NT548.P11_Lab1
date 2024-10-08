# Call the VPC module to create VPC, subnets, and default security group
module "vpc" {
  source = "./modules/vpc"

  vpc_cidr_block            = "10.0.0.0/16"
  public_subnet_cidr_block  = "10.0.1.0/24"
  private_subnet_cidr_block = "10.0.2.0/24"

  tags = {
    Name = "my-vpc"
  }
}

# Use the NAT Gateway module
module "nat_gateway" {
  source = "./modules/nat_gateway"

  public_subnet_id    = module.vpc.public_subnet_id
  
  tags = {
    Name = "my-nat-gateway"
  }
}

#import the route_modules
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