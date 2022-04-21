resource "aws_vpc" "vpcaws" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "${local.naming}-vpc"
  }
}

resource "aws_internet_gateway" "gateway" {
  vpc_id            = aws_vpc.vpcaws.id

  tags = {
    Name = "${local.naming}-gw"
  }
}

resource "aws_route_table" "routeTable" {
  vpc_id            = aws_vpc.vpcaws.id

  route {
    cidr_block = var.rt_cidr
    gateway_id = aws_internet_gateway.gateway.id
  }

  tags = {
    Name = "${local.naming}-rt"
  }
}

resource "aws_subnet" "subnet" {
  vpc_id            = aws_vpc.vpcaws.id
  cidr_block        = var.subnet_cidr
  availability_zone = var.subnet_zone

  tags = {
    Name = "${local.naming}-${var.subnet_purpose}-subnet"
  }
}

resource "aws_route_table_association" "association" {
  subnet_id = aws_subnet.subnet.id
  route_table_id = aws_route_table.routeTable.id
}