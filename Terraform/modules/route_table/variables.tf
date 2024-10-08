variable "vpc_id" {
  type        = string
  description = "ID of the VPC where the route tables will be created"
}

variable "public_subnet_id" {
  type        = string
  description = "ID of the Public Subnet"
}

variable "private_subnet_id" {
  type        = string
  description = "ID of the Private Subnet"
}

variable "internet_gateway_id" {
  type        = string
  description = "ID of the Internet Gateway for the public route table"
}

variable "nat_gateway_id" {
  type        = string
  description = "ID of the NAT Gateway for the private route table"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to resources"
  default     = {}
}
