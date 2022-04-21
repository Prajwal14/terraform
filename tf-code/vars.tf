variable "AccessKey" {
  description = "The Root Access Key for the AWS Account"
  sensitive = true
}

variable "SecretKey" { 
  description = "The Secret key for Root access of AWS Account"
  sensitive = true
}

variable "org" {
  type = string
  default = "bsl"
  description = "Name of the Organization"
}

variable "project" {
  type = string
  default = "bluwyre"
  description = "Name of the Project"
}

variable "env" {
  default = "dev"
  description = "Environment"
}

variable "region" {
  default = "us-east-1"
  description = "Region of the Resource"
}

variable "ec2_instance_type" {
  type        = string
  default = "t2.micro"
  description = "Virtual Machine Instance"
}