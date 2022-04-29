resource "aws_security_group" "allow_traffic" {
  name        = "allow_web_traffic"
  description = "Allow Web traffic"
  vpc_id      = var.ec2_vpc_id

  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "HTTPS"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = merge(
    { "Name" = "${local.naming}-sg" },
    var.tags,
  )
}

resource "aws_network_interface" "nic" {
  count = length(var.eni_ips)
  
  subnet_id       = var.ec2_subnet_id
  private_ips     = [var.eni_ips[count.index]]
  security_groups = [aws_security_group.allow_traffic.id]

  tags = merge(
    { "Name" = "${local.naming}-${var.vm_purpose[count.index]}-eni" },
    var.tags,
  )
}

resource "aws_eip" "eip" {
  count = length(var.eni_ips)

  vpc      = true
  network_interface = element(aws_network_interface.nic[*].id, count.index)
  associate_with_private_ip = var.eni_ips[count.index]

  tags = merge(
    { "Name" = "${local.naming}-${var.vm_purpose[count.index]}-eip" },
    var.tags,
  )
}

resource "aws_instance" "ec2instance" {
  count = length(var.vm_purpose)

  ami                         = var.ec2_ami
  instance_type               = var.ec2_instance_type
  availability_zone           = var.ec2_zone
  key_name                    = "${var.vm_purpose[count.index]}-Key"
  associate_public_ip_address = true

  network_interface {
    device_index = 0
    network_interface_id = element(aws_network_interface.nic[*].id, count.index)
  }

  user_data = local.user_data

  tags = merge(
    { "Name" = "${local.naming}-${var.vm_purpose[count.index]}-vm" },
    var.tags,
  )
}