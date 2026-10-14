region           = "eu-west-1"
vpc_name         = "cmtr-698agnc5-vpc"
vpc_cidr         = "10.10.0.0/16"
igw_name         = "cmtr-698agnc5-igw"
route_table_name = "cmtr-698agnc5-rt"

public_subnets = {
  "cmtr-698agnc5-subnet-public-a" = { cidr = "10.10.1.0/24", az = "eu-west-1a" }
  "cmtr-698agnc5-subnet-public-b" = { cidr = "10.10.3.0/24", az = "eu-west-1b" }
  "cmtr-698agnc5-subnet-public-c" = { cidr = "10.10.5.0/24", az = "eu-west-1c" }
}

allowed_ip_range     = ["18.153.146.156/32", "203.170.48.2/32"]
ssh_sg_name          = "cmtr-698agnc5-ssh-sg"
public_http_sg_name  = "cmtr-698agnc5-public-http-sg"
private_http_sg_name = "cmtr-698agnc5-private-http-sg"

ami_ssm_parameter    = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
instance_type        = "t3.micro"
launch_template_name = "cmtr-698agnc5-template"
asg_name             = "cmtr-698agnc5-asg"
lb_name              = "cmtr-698agnc5-lb"
target_group_name    = "cmtr-698agnc5-tg"
desired_capacity     = 2
min_size             = 2
max_size             = 2

