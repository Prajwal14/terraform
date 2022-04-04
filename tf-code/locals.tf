locals {

#VM name
  vm_name = "${var.project}-vm-${var.env}-01"

#VPC name
  vpc_name = "${var.project}-vpc-${var.env}-01"

#Subnet name
  subnet_name = "${var.project}-subnet-${var.env}-01"

#tags
  required_tags = {
    project     = var.project,
    environment = var.env
  }
  tags = local.required_tags
}
