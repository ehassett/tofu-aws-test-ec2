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
  #checkov:skip=CKV_AWS_79:Ignoring metadata options
  #checkov:skip=CKV_AWS_88:Instance needs a public IP
  #checkov:skip=CKV2_AWS_41:Instance does not need an IAM instance profile

  ami                         = var.ami_id == null ? data.aws_ami.this[0].id : var.ami_id
  associate_public_ip_address = true
  availability_zone           = format("%sa", var.region)
  ebs_optimized               = true
  get_password_data           = var.get_password_data
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.this.key_name
  monitoring                  = true
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [aws_security_group.this.id]

  root_block_device {
    encrypted = true
  }

  tags = {
    Name = var.name
  }
}
