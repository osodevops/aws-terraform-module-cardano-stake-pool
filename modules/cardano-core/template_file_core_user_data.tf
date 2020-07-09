data "template_file" "core_user_data" {
  template = file("${path.module}/scripts/cloud_init_core.sh")

  vars = {
    hostname_prefix         = "core"
    count                   = "0"
    private_dns_zone        = "private"
    region                  = data.aws_region.current.name
    core_node_port          = var.core_node_port
    config_file             = data.template_file.config_template.rendered
    topology_file           = data.template_file.topology_template.rendered
  }
}