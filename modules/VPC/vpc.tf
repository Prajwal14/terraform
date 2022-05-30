##################################################################################
# VPC Configurations
##################################################################################
resource "aws_vpc" "vpcaws" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = var.instance_tenancy
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  tags = merge(
    { "Name" = "${local.naming}-vpc" },
    var.tags,
  )
}


##################################################################################
# Internet Gateway For Public Subnets
##################################################################################
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpcaws.id

  tags = merge(
    { "Name" = "${local.naming}-igw" },
    var.tags,
  )
}


##################################################################################
# Nat Gateway and it's elastic IP
##################################################################################
resource "aws_eip" "nat" {
  count = length(var.private_subnets) > 0 ? 1 : 0

  vpc = true

  tags = merge(
    { "Name" = "${local.naming}-eip" },
    var.tags,
  )
}

resource "aws_nat_gateway" "ngw" {
  count = length(var.private_subnets) > 0 ? 1 : 0

  allocation_id = element(aws_eip.nat[*].id, 0)
  subnet_id     = element(aws_subnet.public_subnet[*].id, 0)

  depends_on = [aws_internet_gateway.igw]

  tags = merge(
    { "Name" = "${local.naming}-nat" },
    var.tags,
  )
}


#####################################################################################
# Public and Private Route table and there association with igw & nat respectively
#####################################################################################
resource "aws_route_table" "public_rtb" {
  count = length(var.public_subnets) > 0 ? 1 : 0

  vpc_id = aws_vpc.vpcaws.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge(
    { "Name" = "${local.naming}-public_rtb" },
    var.tags,
  )
}

resource "aws_route_table" "private_rtb" {
  count = length(var.private_subnets) > 0 ? 1 : 0

  vpc_id = aws_vpc.vpcaws.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = element(aws_nat_gateway.ngw[*].id, 0)
  }

  tags = merge(
    { "Name" = "${local.naming}-private_rtb" },
    var.tags,
  )
}


##################################################################################
# Public and Private Subnets
##################################################################################
resource "aws_subnet" "public_subnet" {
  count = length(var.private_subnets)

  vpc_id            = aws_vpc.vpcaws.id
  cidr_block        = var.public_subnets[count.index]
  availability_zone = element(var.subnet_zones, count.index)

  tags = merge(
    { "Name" = "${local.naming}-public_subnet-${count.index + 1}" },
    var.public_subnets_tags,
    var.tags,
  )
}

resource "aws_subnet" "private_subnet" {
  count = length(var.private_subnets)

  vpc_id            = aws_vpc.vpcaws.id
  cidr_block        = var.private_subnets[count.index]
  availability_zone = element(var.subnet_zones, count.index)

  tags = merge(
    { "Name" = "${local.naming}-private_subnet-${count.index + 1}" },
    var.private_subnets_tags,
    var.tags,
  )
}


##################################################################################
# Subnet association for Route Tables
##################################################################################
resource "aws_route_table_association" "public_association" {
  count = length(var.public_subnets)

  subnet_id      = element(aws_subnet.public_subnet[*].id, count.index)
  route_table_id = element(aws_route_table.public_rtb[*].id, 0)
}

resource "aws_route_table_association" "private_association" {
  count = length(var.private_subnets)

  subnet_id      = element(aws_subnet.private_subnet[*].id, count.index)
  route_table_id = element(aws_route_table.private_rtb[*].id, 0)
}