module "vpc" {
  source     = "../../modules/vpc"
  name       = "prod"
  cidr_block = "10.2.0.0/16"
  tags = {
    environment = "prod"
    agent       = "terraform"
  }
}