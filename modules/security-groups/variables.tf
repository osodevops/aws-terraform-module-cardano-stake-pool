variable "vpc_name" {
  description = "Name of the VPC used for this deployment"
  type        = string
}

variable "environment" {
  description = "Name of this environment"
  type        = string
}

variable "relay_node_port" {
  description = "Port used for relay node operations"
  type        = string
  default     = 3000
}

variable "core_node_port" {
  description = "Port used for core node operations"
  type        = string
  default     = 3000
}
