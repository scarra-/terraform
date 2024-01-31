resource "aws_codedeploy_app" "mediaview" {
  name = "mediaview"
}

resource "aws_codedeploy_deployment_group" "mediaview" {
  deployment_group_name  = "mediaview-deployment-group"
  app_name               = aws_codedeploy_app.mediaview.name
  service_role_arn       = aws_iam_role.codedeploy_service_role.arn
  autoscaling_groups     = ["${aws_autoscaling_group.staging.id}"]
  deployment_config_name = "CodeDeployDefault.OneAtATime"

  ec2_tag_filter {
    type  = "KEY_AND_VALUE"
    key   = "codedeploy"
    value = "true"
  }

  load_balancer_info {
    elb_info {
      name = "terraform-asg-staging"
    }
  }
}
