data "terraform_remote_state" "config" {
  backend = "s3"
  config = {
    bucket = "joeb-com-dev-s3-backend"
    key    = "infra/network/terraform.tfstate"
    region = "eu-west-2"
  }
}