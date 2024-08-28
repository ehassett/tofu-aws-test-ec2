resource "aws_key_pair" "this" {
  key_name   = var.name
  public_key = fileexists("~/.ssh/id_rsa.pub") ? file("~/.ssh/id_rsa.pub") : ""

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

resource "aws_security_group_rule" "allow_all_egress" {
  description = "Allow all egress"

  type      = "egress"
  protocol  = "all"
  from_port = 0
  to_port   = 0

  security_group_id = aws_security_group.this.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_workstation_ingress" {
  description = "Allow all ingress from workstation"

  type      = "ingress"
  protocol  = "all"
  from_port = 0
  to_port   = 0

  security_group_id = aws_security_group.this.id
  cidr_blocks       = [format("%s/32", var.workstation_ip)]
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
