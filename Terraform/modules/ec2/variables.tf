variable "public_instance_type" {
  description = "Instance type for public EC2 instance"
  type        = string
  default     = "t2.micro"  # Bạn có thể đặt giá trị mặc định
}

variable "private_instance_type" {
  description = "Instance type for private EC2 instance"
  type        = string
  default     = "t2.micro"  # Bạn có thể đặt giá trị mặc định
}

variable "public_subnet_id" {
  description = "The ID of the public subnet"
  type        = string
}

variable "private_subnet_id" {
  description = "The ID of the private subnet"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to resources"
  type        = map(string)
}
