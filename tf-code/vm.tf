###########################################################################
## Module Call for keyClock and gateway Virtual machines
###########################################################################

module "edge_vm" {
  source = "../modules/VM"

  project_naming = local.naming
  ec2_vpc_id     = module.edge_vpc.vpc_id
  ec2_subnet_id  = module.edge_vpc.public_subnet_id

  ec2_zone          = "${var.region}a"
  ec2_ami           = var.ec2_ami
  ec2_instance_type = var.ec2_instance_type

  vm_purpose = ["keyClock", "gateway"]
  service    = "edgeService"

  eni_ips = ["10.1.0.15", "10.1.0.16"]

  tags = {
    Environment = "dev"
    Service     = "Edge Services"
  }
}