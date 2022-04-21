module "vm" {
  source      = "../modules/VM"

  vpc_id    = module.vpc.vpc_id
  subnet_id = module.vpc.subnet_id
  ec2_zone  = "${var.region}a"
  ec2_instance_type = var.ec2_instance_type
}