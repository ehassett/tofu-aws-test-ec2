data "aws_ami" "this" {
  count = var.ami_name != null ? 1 : 0

  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "name"
    values = [var.ami_name]
  }
}
