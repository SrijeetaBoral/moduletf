variable "vpc_id" {
    description ="VPC ID for the target group"
    type = string
}

variable "subnet_ids"  {
    description = "Subnet IDs for the ASG and the ALB"
    type = list(string)
}

variable "instance_security_group_ids" {
    description = "Security group IDs attached to the instances"
    type = list(string)
}
variable "alb_security_group_ids" {
    description ="Security group IDs attached to ALB"
    type = list(string)
}

variable "ami_ssm_parameter" {
    description =" SSM parameter name that holds the AMI ID"
    type = string
}

variable "instance_type" {
    description ="EC2 instance type"
    type = string 
}

variable "launch_template_name" {
    description = "Name of the launch template"
    type = string 
}

variable "asg_name" {
    description ="Name of the autoscaling group"
    type = string 
}

variable "lb_name" {
    description = "Name of the load balancer"
    type = string 
}

variable "target_group_name" {
    description = "Name of the target group"
    type = string 
}

variable "desired_capacity" {
    description = "ASG desired capacity"
    type = number 
}

variable "min_size" {
    description = "ASG minimum size"
    type = number 
}

variable "max_size" {
    description = "ASG maximum size"
    type = number 
}

