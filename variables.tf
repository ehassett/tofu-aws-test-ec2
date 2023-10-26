variable "ami_id" {
  description = "ID of the AMI to use. Overwrites ami_name."
  type        = string
  default     = null
}

variable "ami_name" {
  description = "Name of the AMI to use (Amazon-owned only)."
  type        = string
  default     = null
}

variable "get_password_data" {
  description = "Whether to export password data for the instance (usable for Windows instances)."
  type        = bool
  default     = false
}

variable "instance_type" {
  description = "Type (size) of the test instance."
  type        = string
}

variable "name" {
  description = "Name used for test resources."
  type        = string
}

variable "region" {
  description = "AWS region in which to deploy resources."
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet in which to deploy resources."
  type        = string
}

variable "workstation_ip" {
  description = "IP of workstation used to access the test instance."
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC in which to deploy resources."
  type        = string
}
