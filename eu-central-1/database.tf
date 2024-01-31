resource "aws_db_instance" "mediaview" {
  identifier                  = "projectr"
  allocated_storage           = 10
  storage_type                = "gp2"
  engine                      = "mysql"
  engine_version              = "8.0.23"
  instance_class              = "db.t2.micro"
  name                        = "mediaview"
  username                    = var.DB_USER
  password                    = var.DB_PASSWORD
  multi_az                    = false
  allow_major_version_upgrade = false
  apply_immediately           = false
  auto_minor_version_upgrade  = true
  backup_retention_period     = 2
  copy_tags_to_snapshot       = true
  vpc_security_group_ids      = ["${aws_security_group.mediaview.id}"]
  db_subnet_group_name        = "main_subnet_group"
  publicly_accessible         = true
  skip_final_snapshot         = true
}

resource "aws_db_subnet_group" "mediaview" {
  name        = "main_subnet_group"
  description = "Our main group of subnets"
  subnet_ids  = ["${aws_subnet.eu_central_1a_public.id}", "${aws_subnet.eu_central_1b_public.id}"]
}
