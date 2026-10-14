variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block of the VPC"
  type        = string
}

variable "igw_name" {
  description = "Name of the internet gateway"
  type        = string
}

variable "route_table_name" {
  description = "Name of the public route table"
  type        = string
}

variable "public_subnets" {
  description = "Map of the subnet name -> CIDR and availability zone"
  type = map(object({
    cidr = string
    az   = string
  }))
}

