variable "public_subnet_id" {
  description = "The ID of the public subnet where the NAT Gateway will be created"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the resources"
  type        = map(string)
  default     = {}
}
