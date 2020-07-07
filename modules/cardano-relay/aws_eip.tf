resource "aws_eip" "cardano_node" {
  count = 1
  tags  = var.common_tags
}

