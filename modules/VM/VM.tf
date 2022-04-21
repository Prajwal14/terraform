locals{
  naming = var.naming
}
resource "aws_security_group" "allow_traffic" {
  name        = "allow_web_traffic"
  description = "Allow Web traffic"
  vpc_id      = var.vpc_id

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

  tags = {
    Name = "${local.naming}-sg"
  }
}

resource "aws_network_interface" "nic" {
  subnet_id       = var.subnet_id
  private_ips     = ["10.0.0.15"]
  security_groups = [aws_security_group.allow_traffic.id]

}

resource "aws_eip" "eip" {
  vpc      = true
  network_interface = aws_network_interface.nic.id
  associate_with_private_ip = "10.0.0.15"
}

resource "aws_instance" "ec2instance" {

  ami           = "ami-0851b76e8b1bce90b"
  instance_type =  var.ec2_instance_type
  availability_zone = var.ec2_zone
  key_name = "VM-Key"

  network_interface {
    device_index = 0
    network_interface_id = aws_network_interface.nic.id
  }

  user_data = <<-EOF
    #!/bin/bash
    sudo apt update
    sudo apt install nginx -y
    EOF

  tags = {
    Name = "${local.naming}-vm"
  }
}
