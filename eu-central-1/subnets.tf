resource "aws_subnet" "eu_central_1a_public" {
  vpc_id                  = aws_vpc.mediaview_vpc.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = "eu-central-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "Public Subnet"
  }
}

resource "aws_subnet" "eu_central_1b_public" {
  vpc_id                  = aws_vpc.mediaview_vpc.id
  cidr_block              = var.public_subnet_cidr_2
  availability_zone       = "eu-central-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "Public Subnet"
  }
}
