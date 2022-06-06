###########################################################################
## Module Call for Edge Services VPC
###########################################################################

module "edge_vpc" {
  source = "../modules/VPC"

  project_naming = local.naming
  vpc_cidr       = "10.1.0.0/24"

  public_subnets  = ["10.1.0.0/26"]
  private_subnets = []
  subnet_zones    = ["${var.region}a"]

  purpose = "edgeService"

  tags = {
    Environment = "dev"
  }
}


###########################################################################
## Module Call for EKS Services VPC
###########################################################################

module "eks_vpc" {
  source = "../modules/VPC"

  project_naming = local.naming
  vpc_cidr       = "10.0.0.0/20"

  public_subnets  = ["10.0.2.0/25","10.0.2.128/25"]
  private_subnets = ["10.0.0.0/24", "10.0.1.0/24"]
  subnet_zones    = ["${var.region}a", "${var.region}b"]

  public_subnets_tags  = "${merge(tomap({"kubernetes.io/role/elb" = 1}))}"           #{ kubernetes.io/role/elb : 1 }
  private_subnets_tags = "${merge(tomap({"kubernetes.io/role/internal-elb" = 1}))}"  #{ kubernetes.io/role/internal-elb : 1 }

  purpose = "eksApplication"

  tags = {
    Environment = "dev"
  }
}


###########################################################################
## VPC Peering(between edge and eks) and Route table Updation for peering
###########################################################################

resource "aws_vpc_peering_connection" "peering" {
  peer_vpc_id = module.edge_vpc.vpc_id
  vpc_id      = module.eks_vpc.vpc_id
  auto_accept = true

  tags = {
    Name        = "peering-edgeService-eksApplication"
    Environment = "dev"
  }
}

resource "aws_vpc_peering_connection_options" "peering_option" {
  vpc_peering_connection_id = aws_vpc_peering_connection.peering.id

  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }

  depends_on = [aws_vpc_peering_connection.peering]
}

resource "aws_route" "rt_edgeToEks1" {
  route_table_id            = module.edge_vpc.public_rtb_id.0
  destination_cidr_block    = "10.0.0.0/24"
  vpc_peering_connection_id = aws_vpc_peering_connection.peering.id
#   depends_on                = [aws_vpc_peering_connection.peering]
}

resource "aws_route" "rt_edgeToEks2" {
  route_table_id            = module.edge_vpc.public_rtb_id.0
  destination_cidr_block    = "10.0.1.0/24"
  vpc_peering_connection_id = aws_vpc_peering_connection.peering.id
#   depends_on                = [aws_vpc_peering_connection.peering]
}

resource "aws_route" "rt_eksToEdge" {
  route_table_id            = module.eks_vpc.private_rtb_id.0
  destination_cidr_block    = "10.1.0.0/26"
  vpc_peering_connection_id = aws_vpc_peering_connection.peering.id
#   depends_on                = [aws_vpc_peering_connection.peering]
}
