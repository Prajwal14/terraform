output "vpc_id" {
  value = aws_vpc.vpcaws.id
}

output "public_rtb_id" {
  value = aws_route_table.public_rtb.id
}

output "private_rtb_id" {
  value = aws_route_table.private_rtb.*.id
}

output "public_subnet_id" {
  value = aws_subnet.public_subnet.id
}

output "private_subnet_id" {
  value = aws_subnet.private_subnet.*.id
}