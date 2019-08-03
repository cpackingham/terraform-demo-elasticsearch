output "sg_id" {
  value = aws_security_group.es.id
}

output "domain_name" {
  value = aws_elasticsearch_domain.es.domain_name
}

output "endpoint" {
  value = aws_elasticsearch_domain.es.endpoint
}