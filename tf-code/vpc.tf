module "vpc" {
  source      = "../modules/VPC"

  naming      = local.naming
  vpc_cidr    = "10.0.0.0/22"
  subnet_cidr = "10.0.0.0/25"
  rt_cidr     = "0.0.0.0/0"
  subnet_zone = "${var.region}a"
  subnet_purpose = "edgeService"
}
