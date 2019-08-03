variable "vpc_id" {
  type = string
  description = "The vpc in which to place the cluster."
}

variable "authorized_cidr_blocks" {
  type = list(string)
  description = "A list of cidr blocks authorized to access the cluster."
}

variable "subnet_ids" {
  type = list(string)
  description = "List of subnets in which cluster nodes may be placed."
}

variable "instance_type" {
  type = string
  description = "Type of instance in the cluster."
  default = "r4.large.elasticsearch"
}

variable "num_nodes" {
  type = number
  description = "The number of nodes in the cluster."
  default = 1
}

variable "volume_size" {
  type = number
  description = "The size of the EBS volumes on each node."
  default = 20
}

variable "domain" {
  type = string
  description = "Name of the domain of the cluster."
}

variable "tags" {
  type = map(string)
  description = "Default tags to apply to cluster resources."
}