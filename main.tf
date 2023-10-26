resource "aws_key_pair" "this" {
  key_name   = var.name
  public_key = file("~/.ssh/id_rsa.pub")

  tags = {
    Name = var.name
  }
}

resource "aws_security_group" "this" {
  name        = var.name
  description = "SG for test instances"
  vpc_id      = var.vpc_id

  tags = {
    Name = var.name
  }
}

resource "aws_security_group_rule" "icmp_from_workstation" {
  description = "Allow ICMP from workstation"

  type      = "ingress"
  protocol  = "ICMP"
  from_port = -1
  to_port   = -1

  security_group_id = aws_security_group.this.id
  cidr_blocks       = [format("%s/32", var.workstation_ip)]
}

resource "aws_security_group_rule" "ssh_from_workstation" {
  description = "Allow SSH from workstation"

  type      = "ingress"
  protocol  = "TCP"
  from_port = 22
  to_port   = 22

  security_group_id = aws_security_group.this.id
  cidr_blocks       = [format("%s/32", var.workstation_ip)]
}


resource "aws_security_group_rule" "rdp_from_workstation" {
  description = "Allow RDP from workstation"

  type      = "ingress"
  protocol  = "TCP"
  from_port = 3389
  to_port   = 3389

  security_group_id = aws_security_group.this.id
  cidr_blocks       = [format("%s/32", var.workstation_ip)]
}

resource "aws_security_group_rule" "https_to_any" {
  description = "Allow HTTPS to any"

  type      = "egress"
  protocol  = "TCP"
  from_port = 443
  to_port   = 443

  security_group_id = aws_security_group.this.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_instance" "this" {
  ami                         = var.ami_id == null ? data.aws_ami.this[0].id : var.ami_id
  associate_public_ip_address = true
  availability_zone           = format("%sa", var.region)
  get_password_data           = var.get_password_data
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.this.key_name
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [aws_security_group.this.id]

  tags = {
    Name = var.name
  }
}
