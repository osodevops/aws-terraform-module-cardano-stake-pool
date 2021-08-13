data "aws_subnet_ids" "public" {
  vpc_id = data.aws_vpc.cardano.id

  tags = {
    Type = "Public*"
  }
}