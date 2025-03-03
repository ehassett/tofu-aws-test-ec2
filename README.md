# tofu-aws-test-ec2

A simple OpenTofu (Terraform) workspace for working with a test EC2 instance.

# Contents

- [tofu-aws-test-ec2](#tofu-aws-test-ec2)
- [Contents](#contents)
- [Contributing](#contributing)
- [Usage](#usage)
- [terraform-docs](#terraform-docs)
  - [Requirements](#requirements)
  - [Providers](#providers)
  - [Inputs](#inputs)
  - [Outputs](#outputs)
  - [Modules](#modules)
  - [Resources](#resources)

# Contributing

- Follow [conventional commits v1.0.0](https://www.conventionalcommits.org/en/v1.0.0/) for commits _and_ PR titles.
- Follow [GitHub Flow](https://githubflow.github.io) for branching strategy and PR process.

# Usage

Include the required variables in `terraform.tfvars` and run `tofu apply` (after initializing).
For an easier way to include your local `workstation_ip`, run:

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

| Name                                                                     | Version |
| ------------------------------------------------------------------------ | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | ~> 1.8  |
| <a name="requirement_aws"></a> [aws](#requirement_aws)                   | ~> 5.0  |

## Providers

| Name                                             | Version |
| ------------------------------------------------ | ------- |
| <a name="provider_aws"></a> [aws](#provider_aws) | 5.88.0  |

## Inputs

| Name                                                                                                               | Description                                                                                          | Type     | Default | Required |
| ------------------------------------------------------------------------------------------------------------------ | ---------------------------------------------------------------------------------------------------- | -------- | ------- | :------: |
| <a name="input_ami_id"></a> [ami_id](#input_ami_id)                                                                | ID of the AMI to use. Overwrites ami_name.                                                           | `string` | `null`  |    no    |
| <a name="input_ami_name"></a> [ami_name](#input_ami_name)                                                          | Name of the AMI to use (Amazon-owned only).                                                          | `string` | `null`  |    no    |
| <a name="input_associate_public_ip_address"></a> [associate_public_ip_address](#input_associate_public_ip_address) | Whether to associate a public IP address with the instance.                                          | `bool`   | `false` |    no    |
| <a name="input_get_password_data"></a> [get_password_data](#input_get_password_data)                               | Whether to export password data for the instance (usable for Windows instances).                     | `bool`   | `false` |    no    |
| <a name="input_instance_type"></a> [instance_type](#input_instance_type)                                           | Type (size) of the test instance.                                                                    | `string` | n/a     |   yes    |
| <a name="input_name"></a> [name](#input_name)                                                                      | Name used for test resources.                                                                        | `string` | n/a     |   yes    |
| <a name="input_region"></a> [region](#input_region)                                                                | AWS region in which to deploy resources.                                                             | `string` | n/a     |   yes    |
| <a name="input_subnet_id"></a> [subnet_id](#input_subnet_id)                                                       | ID of the subnet in which to deploy resources. Overwrites subnet_name.                               | `string` | `null`  |    no    |
| <a name="input_subnet_name"></a> [subnet_name](#input_subnet_name)                                                 | Name of the subnet to use.                                                                           | `string` | `null`  |    no    |
| <a name="input_vpc_id"></a> [vpc_id](#input_vpc_id)                                                                | ID of the VPC in which to deploy resources.                                                          | `string` | n/a     |   yes    |
| <a name="input_workstation_ip"></a> [workstation_ip](#input_workstation_ip)                                        | IP of workstation used to access the test instance. If omitted, all ingress traffic will be allowed. | `string` | `null`  |    no    |

## Outputs

| Name                                                                                      | Description                               |
| ----------------------------------------------------------------------------------------- | ----------------------------------------- |
| <a name="output_plaintext_password"></a> [plaintext_password](#output_plaintext_password) | Plaintext password for the test instance. |
| <a name="output_private_ip"></a> [private_ip](#output_private_ip)                         | Private IP address of the test instance.  |
| <a name="output_public_ip"></a> [public_ip](#output_public_ip)                            | Public IP address of the test instance.   |

## Modules

No modules.

## Resources

| Name                                                                                                                                                 | Type        |
| ---------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [aws_instance.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance)                                            | resource    |
| [aws_key_pair.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair)                                            | resource    |
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group)                                | resource    |
| [aws_security_group_rule.allow_all_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule)          | resource    |
| [aws_security_group_rule.allow_all_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule)         | resource    |
| [aws_security_group_rule.allow_workstation_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource    |
| [aws_ami.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami)                                                   | data source |
| [aws_subnet.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet)                                             | data source |

<!-- END_TF_DOCS -->
