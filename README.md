# tofu-aws-test-ec2

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

# terraform-docs

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.8 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.74.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami_id"></a> [ami\_id](#input\_ami\_id) | ID of the AMI to use. Overwrites ami\_name. | `string` | `null` | no |
| <a name="input_ami_name"></a> [ami\_name](#input\_ami\_name) | Name of the AMI to use (Amazon-owned only). | `string` | `null` | no |
| <a name="input_associate_public_ip_address"></a> [associate\_public\_ip\_address](#input\_associate\_public\_ip\_address) | Whether to associate a public IP address with the instance. | `bool` | `false` | no |
| <a name="input_get_password_data"></a> [get\_password\_data](#input\_get\_password\_data) | Whether to export password data for the instance (usable for Windows instances). | `bool` | `false` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Type (size) of the test instance. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name used for test resources. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS region in which to deploy resources. | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | ID of the subnet in which to deploy resources. Overwrites subnet\_name. | `string` | `null` | no |
| <a name="input_subnet_name"></a> [subnet\_name](#input\_subnet\_name) | Name of the subnet to use. | `string` | `null` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of the VPC in which to deploy resources. | `string` | n/a | yes |
| <a name="input_workstation_ip"></a> [workstation\_ip](#input\_workstation\_ip) | IP of workstation used to access the test instance. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_plaintext_password"></a> [plaintext\_password](#output\_plaintext\_password) | Plaintext password for the test instance. |
| <a name="output_public_ip"></a> [public\_ip](#output\_public\_ip) | Public IP address of the test instance. |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_instance.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_key_pair.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) | resource |
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.allow_all_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_workstation_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_ami.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_subnet.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
<!-- END_TF_DOCS -->
