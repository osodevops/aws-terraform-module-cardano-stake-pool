data "template_file" "relay_user_data" {
  template = file("${path.module}/scripts/cloud_init_relay.sh")

  vars = {
    eip                       = aws_eip.cardano_node[0].id
    eip_ip4                   = aws_eip.cardano_node[0].public_ip
    region                    = data.aws_region.current.name
    relay_node_port           = var.relay_node_port
    node_server_username      = "cardano"
  }
}