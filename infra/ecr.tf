provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}

import {
  to = aws_ecrpublic_repository.rails_api
  id = "my-blog-api"
}

resource "aws_ecrpublic_repository" "rails_api" {
  repository_name = "my-blog-api"
  provider        = aws.us_east_1
  lifecycle {
    prevent_destroy = true
  }
}

import {
  to = aws_ecrpublic_repository.react_app
  id = "my-blog-app"
}

resource "aws_ecrpublic_repository" "react_app" {
  repository_name = "my-blog-app"
  provider        = aws.us_east_1
  lifecycle {
    prevent_destroy = true
  }
}
