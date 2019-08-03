variable "name" {
  type = string
  description = "Name of the VPC."
}

variable "cidr_block" {
  type = string
  description = "The cidr block of the VPC you want to create."
}

variable "tags" {
  type = map(string)
  description = "Common tags to apply to resources in this module."
}