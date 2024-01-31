resource "aws_launch_configuration" "staging" {
  image_id             = "ami-053c5d58cde670f97"
  name                 = "mediaview"
  instance_type        = "t2.small"
  security_groups      = ["${aws_security_group.web.id}"]
  key_name             = "${var.aws_key_name}"
  iam_instance_profile = "${aws_iam_instance_profile.codedeploy.name}"
  user_data            = "${file("installers/codedeploy-agent_install.sh")}"

  lifecycle {
    create_before_destroy = true
  }

  root_block_device {
    volume_type = "gp2"
    volume_size = "20"
  }
}

resource "aws_autoscaling_group" "staging" {
  name                      = "mediaview"
  launch_configuration      = "${aws_launch_configuration.staging.id}"
  # availability_zones        = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
  min_size                  = 1
  max_size                  = 1
  load_balancers            = ["${aws_lb.staging.name}"]
  health_check_type         = "ELB"
  vpc_zone_identifier       = ["${aws_subnet.eu_central_1a_public.id}"]
  health_check_grace_period = 60
  desired_capacity          = 1
}

## Security Group for ELB
resource "aws_security_group" "elb" {
  name   = "terraform-staging-elb"
  vpc_id = "${aws_vpc.mediaview_vpc.id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_lb" "staging" {
  name               = "terraform-asg-staging"
  security_groups    = ["${aws_security_group.elb.id}"]
  subnets            = ["${aws_subnet.eu_central_1a_public.id}", "${aws_subnet.eu_central_1b_public.id}"]
  internal           = false
  load_balancer_type = "application"
}

resource "aws_lb_target_group" "be" {
  name     = "terraform-asg-staging"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.mediaview_vpc.id}"
}

resource "aws_lb_listener" "be" {
  load_balancer_arn = aws_lb.staging.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.be.arn
  }
}

resource "aws_lb_listener" "be-secure" {
  load_balancer_arn = aws_lb.staging.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "arn:aws:acm:eu-central-1:462134158394:certificate/03d996b3-0c3b-4e57-b3bb-7f1d83238a81"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.be.arn
  }
}

