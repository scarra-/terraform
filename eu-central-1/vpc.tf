resource "aws_vpc" "mediaview_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true

  tags = {
    Name        = "mediaview-vpc"
    Environment = "staging"
  }
}

resource "aws_internet_gateway" "mediaview_gateway" {
  vpc_id = aws_vpc.mediaview_vpc.id
}
