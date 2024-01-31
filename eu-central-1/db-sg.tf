resource "aws_security_group" "mediaview" {
  name        = "main_rds_sg"
  description = "Allow all inbound traffic"
  vpc_id      = aws_vpc.mediaview_vpc.id

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds_sg"
  }
}
