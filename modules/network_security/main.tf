resource "aws_security_group" "ssh" {
  name   = var.ssh_sg_name
  vpc_id = var.vpc_id
  tags = {
    Name = var.ssh_sg_name
  }
}

resource "aws_security_group" "public_http" {
  name = var.public_http_sg_name
  vpc_id =var.vpc_id
  tags = {
    Name = var.public_http_sg_name
  }

}

resource "aws_security_group" "private_http" {
  name = var.private_http_sg_name
  vpc_id = var.vpc_id
  tags = {
    Name = var.private_http_sg_name
  }

}
resource "aws_security_group_rule" "ssh_in" {
  type              = "ingress"
  security_group_id = aws_security_group.ssh.id
  protocol          = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_blocks       = var.allowed_ip_range

}

resource "aws_security_group_rule" "public_http_in" {
  type              = "ingress"
  security_group_id = aws_security_group.public_http.id
  protocol          = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_blocks       = var.allowed_ip_range
}

resource "aws_security_group_rule" "private_http_in" {
  type                     = "ingress"
  security_group_id        = aws_security_group.private_http.id
  protocol                 = "tcp"
  from_port                = 80
  to_port                  = 80
  source_security_group_id = aws_security_group.public_http.id

}


resource "aws_security_group_rule" "egress" {
  for_each = {
    ssh          = aws_security_group.ssh.id
    public_http  = aws_security_group.public_http.id
    private_http = aws_security_group.private_http.id

  }

  type              = "egress"
  security_group_id = each.value
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
}
