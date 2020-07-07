output "relay_eip" {
  value = aws_eip.cardano_node[*].public_ip
}