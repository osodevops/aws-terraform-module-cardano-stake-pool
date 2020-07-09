// Topology  template
data "template_file" "topology_template" {
  template = <<EOF
{
  \"Producers\": [
    {
      \"addr\": \""${element(keys(var.relay_nodes), 0)}"\",
      \"port\": ${element(values(var.relay_nodes), 0)},
      \"valency\": 1
    }
  ]
}
EOF
}