resource "aws_route_table" "eu_central_1a_public" {
  vpc_id = aws_vpc.mediaview_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.mediaview_gateway.id
  }

  tags = {
    Name = "Public Subnet"
  }
}

resource "aws_route_table_association" "eu_central_1a_public" {
  subnet_id      = aws_subnet.eu_central_1a_public.id
  route_table_id = aws_route_table.eu_central_1a_public.id
}

resource "aws_route_table_association" "eu_central_1b_public" {
  subnet_id      = aws_subnet.eu_central_1b_public.id
  route_table_id = aws_route_table.eu_central_1a_public.id
}
