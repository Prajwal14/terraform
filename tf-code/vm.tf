resource "aws_instance" "myinstance" {

  ami           = "ami-0851b76e8b1bce90b"
  instance_type = var.ec2_instance_type

  subnet_id              = aws_subnet.mysubnet.id

  user_data = <<-EOF
    #!/bin/bash
    sudo apt-get install nginx
    EOF

  tags = {
    Name = local.vm_name
  }
}