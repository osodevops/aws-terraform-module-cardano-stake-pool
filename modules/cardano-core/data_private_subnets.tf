data "aws_subnet_ids" "private" {
  vpc_id = data.aws_vpc.cardano.id

  tags = {
    Type = "Private*"
  }
}