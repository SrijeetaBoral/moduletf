variable "region" {
  description = "AWS region for all the resources"
  type        = string
}
variable "vpc_name" {
  description = "VPC name"
  type        = string
}
variable "vpc_cidr" {
  description = "CIDR block"
  type        = string
}

variable "igw_name" {
  description = "Internet gateway name"
  type        = string
}
variable "route_table_name" {
  description = "Route table name"
  type        = string
}
variable "public_subnets" {
  description = "Public subnets:name=> cidr and az"
  type = map(object({
    cidr = string
    az   = string
  }))
}

variable "allowed_ip_range" {
  description = "CIDR blocks allowed for SSH and HTTP"
  type        = list(string)
}
variable "ssh_sg_name" {
  description = "CIDR blocks allowed for SSH and HTTP"
  type        = string
}

variable "public_http_sg_name" {
  description = "Public HTTP security group name"
  type        = string
}

variable "private_http_sg_name" {
  description = "Private HTTP security group name"
  type        = string
}

variable "ami_ssm_parameter" {
  description = "SSM parameter of the AMI ID"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}



variable "launch_template_name" {
  description = "Launch template name"
  type        = string
}

variable "asg_name" {
  description = "Auto Scaling group name"
  type        = string
}
variable "lb_name" {
  description = "Load balancer name"
  type        = string
}
variable "target_group_name" {
  description = "Target group name"
  type        = string
}
variable "desired_capacity" {
  description = "ASG desired capacity"
  type        = number
}
variable "min_size" {
  description = "ASG minimum size"
  type        = number
}
variable "max_size" {
  description = "ASG maximum size"
  type        = number
}