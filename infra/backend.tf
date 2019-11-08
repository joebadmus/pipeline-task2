terraform {
  backend "s3" {
    bucket = "joeb-com-dev-s3-backend"
    key    = "infra/webserver/terraform.tfstate"
    region = "eu-west-2"
  }
}