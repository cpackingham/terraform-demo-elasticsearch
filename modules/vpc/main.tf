# The vpc itself
resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = merge(var.tags, {Name = var.name})
}

# We want internet access!
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = merge(var.tags, {Name = "${var.name}-igw"})
}

# Create a route table entry for the internet gateway
resource "aws_route" "igw" {
  route_table_id = aws_vpc.main.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.main.id
}

# Get the region so we can set an availability zone.
data "aws_region" "current" {}

# Set up the main subnet. We only need one.
resource "aws_subnet" "main" {
  vpc_id = aws_vpc.main.id
  # Make the AZ whichever region we're in - a, like us-west-2a
  availability_zone = "${data.aws_region.current.name}a"
  cidr_block = cidrsubnet(var.cidr_block, 4, 1)
  map_public_ip_on_launch = true

  tags = merge(var.tags, {Name = "${var.name}-a"})
}