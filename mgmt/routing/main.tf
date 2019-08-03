data "aws_vpc" "test" {
  id = var.test_vpc_id
}

data "aws_vpc" "prod" {
  id = var.prod_vpc_id
}

data "aws_vpc" "mgmt" {
  id = var.mgmt_vpc_id
}

# The peering connection itself
resource "aws_vpc_peering_connection" "mgmt_test" {
  peer_vpc_id = var.test_vpc_id
  vpc_id      = var.mgmt_vpc_id
  auto_accept = true

  tags = merge(var.tags, { Name = "test <-> mgmt" })
}

# Connections from mgmt to test
resource "aws_route" "mgmt_test" {
  route_table_id            = data.aws_vpc.mgmt.main_route_table_id
  destination_cidr_block    = data.aws_vpc.test.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.mgmt_test.id
}

# Connections from test to mgmt
resource "aws_route" "test_mgmt" {
  route_table_id            = data.aws_vpc.test.main_route_table_id
  destination_cidr_block    = data.aws_vpc.mgmt.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.mgmt_test.id
}

resource "aws_vpc_peering_connection" "mgmt_prod" {
  peer_vpc_id = var.prod_vpc_id
  vpc_id      = var.mgmt_vpc_id
  auto_accept = true

  tags = merge(var.tags, { Name = "prod <-> mgmt" })
}

# Connections from mgmt to prod
resource "aws_route" "mgmt_prod" {
  route_table_id            = data.aws_vpc.mgmt.main_route_table_id
  destination_cidr_block    = data.aws_vpc.prod.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.mgmt_prod.id
}

# Connections from prod to mgmt
resource "aws_route" "prod_mgmt" {
  route_table_id            = data.aws_vpc.prod.main_route_table_id
  destination_cidr_block    = data.aws_vpc.mgmt.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.mgmt_prod.id
}