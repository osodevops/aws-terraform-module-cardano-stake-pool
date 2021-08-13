output "relay_sg_id" {
  value = aws_security_group.relay.id
}

output "core_sg_id" {
  value = aws_security_group.core.id
}
