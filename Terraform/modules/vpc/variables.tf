# CIDR block for the VPC
variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

# CIDR block for the public subnet
variable "public_subnet_cidr_block" {
  description = "CIDR block for the public subnet"
  type        = string
}

# CIDR block for the private subnet
variable "private_subnet_cidr_block" {
  description = "CIDR block for the private subnet"
  type        = string
}

# Tags for the resources
variable "tags" {
  description = "Tags to apply to all resources in the VPC module"
  type        = map(string)
  default     = {}
}
