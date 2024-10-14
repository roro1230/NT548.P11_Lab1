variable "allowed_ssh_ip" {
  description = "The IP address allowed for SSH access"
  type        = string
  default     = "0.0.0.0/0"  # Optional: Use a default IP for testing, replace with a more secure IP if needed
}