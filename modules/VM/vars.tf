variable "project_naming" {
  description = "Project Name"
  type        = string
  default     = ""
}

variable "ec2_vpc_id" {  
  description = "Id of VPC for EC2"
  type        = string
  default     = ""
}

variable "ec2_subnet_id" {
  description = "Id of Subnet for EC2"
  type        = string
  default     = ""
}

variable "ec2_zone"{
  description = "Availablity zone for EC2"
  type        = string
  default     = ""
}

variable "ec2_ami"{
  description = "Image of EC2 Instance"
  type        = string
  default     = ""
}

variable "ec2_instance_type" {
  description = "Instance size of EC2"
  type        = string
  default     = ""
}

variable "vm_purpose"{
  description = "Purpose of VM"
  type        = list(string)
  default     = []
}

variable "service"{
  description = "Service name under which VM are launched"
  type        = string
  default     = ""
}

variable "eni_ips"{
  description = "Private IP of eni"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

locals {
  naming = "${var.project_naming}-${var.service}"

  user_data = <<-EOF
    #!/bin/bash
    sudo apt update
    sudo apt install nginx -y
    EOF
}