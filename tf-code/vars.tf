variable "AccessKey" {
  description = "The Root Access Key for the AWS Account"
  sensitive   = true
}

variable "SecretKey" {
  description = "The Secret key for Root access of AWS Account"
  sensitive   = true
}

variable "org" {
  description = "Name of the Organization"
  type        = string
  default     = "bsl"
}

variable "project" {
  description = "Name of the Project"
  type        = string
  default     = "bluwyre"
}

variable "env" {
  description = "Environment"
  type        = string
  default     = "dev"
}

variable "region" {
  description = "Region of the Resources"
  type        = string
  default     = "us-east-1"
}

variable "ec2_ami" {
  description = "Virtual Machine Image"
  type        = string
  default     = "ami-04505e74c0741db8d"
}

variable "ec2_instance_type" {
  description = "Virtual Machine Instance"
  type        = string
  default     = "t2.micro"
}
