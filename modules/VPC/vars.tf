variable "vpc_cidr" {
  description = "CIDR of VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "enable_dns_hostnames" {
  description = "Should be true to enable DNS hostnames in the VPC"
  type        = bool
  default     = false
}

variable "enable_dns_support" {
  description = "Should be true to enable DNS support in the VPC"
  type        = bool
  default     = true
}

variable "instance_tenancy" {
  description = "A tenancy option for instances launched into the VPC"
  type        = string
  default     = "default"
}

variable "public_subnets" {
  description = "CIDR of Public Subnet"
  type        = list(string)
  default     = []
}

variable "private_subnets" {
  description = "CIDR of Private Subnets"
  type        = list(string)
  default     = []
}

variable "subnet_zones" {
  description = "Availablity zones for Subnets"
  type        = list(string)
  default     = []
}

variable "project_naming"{
  description = "Project Name"
  type        = string
  default     = ""
}

variable "purpose" {
  description = "Purpose of VPC"
  type        = string
  default     = "general"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

locals {
  naming = "${var.project_naming}-${var.purpose}"
}