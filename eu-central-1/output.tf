output "sg_id" {
  value = aws_security_group.web.id
}

output "pub_1a_subnet_id" {
  value = aws_subnet.eu_central_1a_public.id
}

output "vpc_id" {
  value = aws_vpc.mediaview_vpc.id
}
