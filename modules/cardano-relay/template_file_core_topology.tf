// Topology  template
data "template_file" "topology_template" {
  template = <<EOF
{
  \"Producers\": [
    {
      \"operator\": \"Core node\",
      \"addr\": \"${var.core_node_ip}\",
      \"port\": 3000,
      \"valency\": 1
    },
    {
      \"addr\": \"relays-new.shelley-testnet.dev.cardano.org\",
      \"port\": 3001,
      \"valency\": 2
    }
  ]
}
EOF
}