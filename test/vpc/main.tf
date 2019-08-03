module "vpc" {
  source = "../../modules/vpc"
  name = "test"
  cidr_block = "10.1.0.0/16"
  tags = {
    environment = "test"
    agent = "terraform"
  }
}