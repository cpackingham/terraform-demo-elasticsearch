module "vpc" {
  source = "../../modules/vpc"
  name = "mgmt"
  cidr_block = "10.0.0.0/16"
  tags = {
    environment = "mgmt"
    agent = "terraform"
  }
}