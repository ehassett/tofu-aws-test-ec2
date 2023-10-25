# tofu-aws-ec2-testing

A simple OpenTofu (Terraform) workspace for working with a test EC2 instance.

## Usage

Include the required variables in `terraform.tfvars` and run `tofu apply` (after initializing).
For an easier way to include the `workstation_ip`, run
```bash
IP=`curl --silent ifconfig.me`; tofu apply -var workstation_ip=$IP
```

Example `terraform.tfvars`:
```hcl
ami_name      = "Windows_Server-2022-English-Full-Base-*"
instance_type = "t3.large"
name          = "testing"
region        = "us-west-2"
subnet_id     = "subnet-00000000000000000"
vpc_id        = "vpc-00000000000000000"
```