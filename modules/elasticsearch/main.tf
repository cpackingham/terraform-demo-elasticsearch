data "aws_vpc" "main" {
  id = var.vpc_id
}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

resource "aws_security_group" "es" {
  name        = "${var.domain}-elasticsearch"
  description = "Allows ingress on 443 for the ${var.domain} domain."
  vpc_id      = var.vpc_id

  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"

    cidr_blocks = var.authorized_cidr_blocks
  }
}

resource "aws_iam_service_linked_role" "es" {
  aws_service_name = "es.amazonaws.com"
}

resource "aws_elasticsearch_domain" "es" {
  domain_name           = var.domain
  elasticsearch_version = "6.7"

  cluster_config {
    instance_type = var.instance_type
    instance_count = var.num_nodes
  }

  vpc_options {
    subnet_ids = var.subnet_ids
    security_group_ids = [
      aws_security_group.es.id
    ]
  }

  snapshot_options {
    automated_snapshot_start_hour = 23
  }

  ebs_options {
    ebs_enabled = true
    volume_size = var.volume_size
  }

  tags = var.tags

  depends_on = [
    "aws_iam_service_linked_role.es",
  ]
}