provider "aws" {
  region = "eu-west-2"
}

resource "aws_s3_bucket" "dev-s3-backend" {
  bucket = "joeb-com-dev-s3-backend"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }
}