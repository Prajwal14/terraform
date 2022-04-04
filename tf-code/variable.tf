variable "AccessKey" {
}

variable "SecretKey" {  
}

variable "project" {
  type = string
  default = "poc"
}

variable "env" {
  default = "dev"
}

variable "ec2_instance_type" {
  type        = string
  default = "t2.micro"
}