provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}

resource "aws_ecrpublic_repository" "rails_api" {
  repository_name = "my-blog-api"
  provider        = aws.us_east_1
  count           = var.create_ecr_repo ? 1 : 0
}

resource "aws_ecrpublic_repository" "react_app" {
  repository_name = "my-blog-app"
  provider        = aws.us_east_1
  count           = var.create_ecr_repo ? 1 : 0
}
