data "aws_ssm_parameter" "ami" {
  name = var.ami_ssm_parameter
}

resource "aws_launch_template" "this" {
  name          = var.launch_template_name
  image_id      = data.aws_ssm_parameter.ami.value
  instance_type = var.instance_type




  network_interfaces {
    associate_public_ip_address = true
    delete_on_termination       = true
    security_groups             = var.instance_security_group_ids

  }

  user_data = base64encode(<<-EOT
  #!/bin/bash 
  dnf install -y httpd 
  systemctl enable --now httpd 
  TOKEN=$(curl -s -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
  IID=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/instance-id)
  AZ=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/placement/availability-zone)
  IP=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/local-ipv4)
  cat > /var/www/html/index.html <<HTML 
  <h1>Launch template ${var.launch_template_name}</h1>
  <p>Instance type: ${var.instance_type}</p>
  <p>Instance ID: $IID</p>
  <p>Availability Zone: $AZ</p>
  <p>Private IP: $IP</p>
    HTML
    EOT 
  )

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }
}


resource "aws_lb_target_group" "this" {
  name     = var.target_group_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb" "this" {
  name               = var.lb_name
  load_balancer_type = "application"
  subnets            = var.subnet_ids
  security_groups    = var.alb_security_group_ids
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}

resource "aws_autoscaling_group" "this" {
  name                = var.asg_name
  desired_capacity    = var.desired_capacity
  min_size            = var.min_size
  max_size            = var.max_size
  vpc_zone_identifier = var.subnet_ids

  launch_template {
    id      = aws_launch_template.this.id
    version = aws_launch_template.this.latest_version

  }

  lifecycle {
    ignore_changes = [load_balancers, target_group_arns]
  }
}

resource "aws_autoscaling_attachment" "this" {
  autoscaling_group_name = aws_autoscaling_group.this.id
  lb_target_group_arn    = aws_lb_target_group.this.arn
}

