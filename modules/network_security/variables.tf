variable "vpc_id" {
  description = "VPC ID of the security groups"
  type        = string
}

variable "allowed_ip_range" {
  description = "CIDR blocks allowed to reach SSH and public HTTP"
  type        = list(string)
}

variable "ssh_sg_name" {
  description = "Name of the ssh security group"
  type        = string
}

variable "public_http_sg_name" {
  description = "Name of the public HTTP security group"
  type        = string

}

variable "private_http_sg_name" {
  description = "Name of the private HTTP security group"
  type        = string
}
