variable "public_sg_id" {
  description = "ID of the Public Security Group"
  type        = string
}

variable "private_sg_id" {
  description = "ID of the Private Security Group"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC where EC2 instances will be created"
  type        = string
}

variable "public_subnet_id" {
  description = "The ID of the Public Subnet"
  type        = string
}

variable "private_subnet_id" {
  description = "The ID of the Private Subnet"
  type        = string
}

variable "public_instance_type" {
  description = "Instance type for the Public EC2 instance"
  type        = string
}

variable "private_instance_type" {
  description = "Instance type for the Private EC2 instance"
  type        = string
}

variable "tags" {
  description = "Tags for resources"
  type        = map(string)
}

variable "key_name" {
  description = "The name of the SSH key pair to use for the EC2 instance"
  type        = string
}
