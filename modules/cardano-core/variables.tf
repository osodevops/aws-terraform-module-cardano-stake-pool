variable "asg_min_size" {
  default = 0
}

variable "ami_owner_account" {
  type = string
}

variable "asg_min_size" {
  default = 1
}

variable "asg_max_size" {
  default = 1
}

variable "asg_desired_capacity" {
  default = 1
}

variable "ec2_key_name" {
  type        = string
  description = "Set the EC2 Key name"
  default     = ""
}

variable "ec2_instance_type" {
  type        = string
  description = "Set EC2 instance type for Openvpn server"
  default     = "t2.small"
}

variable "environment" {
  type = string
}

variable "common_tags" {
  type = map(string)
}

variable "node_port" {
  description = "External port number to run core node on."
  type        = string
}

variable "node_root_disk_size" {
  description = "Size of the root volume in GB's"
  type        = number
  default     = 40
}

variable "vpc_name" {
  description = "Name of the VPC we are deploying to"
  type        = string
}

variable "node_security_group_id" {
  description = "ID of the SG defined by the security-groups module"
  type        = string
}

locals {
  log_path          = "/opt/cardano/cnode/logs"
  parameter_prefix  = "/${var.environment}"
  ami_name          = "CARDANO-NODE-*"
}