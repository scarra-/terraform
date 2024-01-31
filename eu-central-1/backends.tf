terraform {
  backend "s3" {
    key            = "staging/eu-central-1/terraform.tfstate"
    bucket         = "project-r-tf-state"
    region         = "eu-central-1"
    access_key     = var.AWS_ACCESS_KEY_ID
    secret_key     = var.AWS_SECRET_ACCESS_KEY
    dynamodb_table = "project-r-tf-state"
  }
}
