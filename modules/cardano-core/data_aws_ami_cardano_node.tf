data "aws_ami" "cardano_node" {
  most_recent = true

  filter {
    name   = "name"
    values = [local.ami_name]
  }
  owners = [local.ami_owner]
}
