locals {

#VM name
  vm_name = "${var.project}-vm-${var.env}-01"

#VPC name
  vpc_name = "${var.project}-vpc-${var.environment}-01"

#Subnet name
  subnet_name = "${var.project}-subnet-${var.environment}-01"

#tags
  required_tags = {
    project     = var.project,
    environment = var.env
  }
  tags = local.required_tags
}