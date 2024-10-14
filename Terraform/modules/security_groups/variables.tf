variable "vpc_id" {
  description = "The ID of the VPC where Security Groups will be created"
  type        = string
}

variable "tags" {
  description = "Tags for resources"
  type        = map(string)
}
variable "allowed_ssh_ip" {
  description = "IP address that is allowed to SSH into the Public instance"
  type        = string
}