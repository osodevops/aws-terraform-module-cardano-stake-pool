data "aws_vpc" "cardano" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}
