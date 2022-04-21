variable "vpc_cidr" {
  description = "CIDR of VPC"
  default = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "CIDR of Subnet"
  default = "10.0.0.0/24"
}

variable "rt_cidr" {
  description = "CIDR of Subnet"
  default = "0.0.0.0/0"
}

variable "subnet_zone" {
  description = "Availablity zone of Subnet"
  default = "us-east-1"
}

variable "subnet_purpose" {
  description = "Availablity zone of Subnet"
  default = "general"
}