variable "test_vpc_id" {
  type        = string
  description = "The id of the test vpc."
}

variable "prod_vpc_id" {
  type        = string
  description = "The id of the prod vpc."
}

variable "mgmt_vpc_id" {
  type        = string
  description = "The id of the mgmt vpc."
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to resources."
  default = {
    environment = "mgmt"
    agent       = "terraform"
  }
}