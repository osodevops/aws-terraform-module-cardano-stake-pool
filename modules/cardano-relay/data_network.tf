data "aws_vpc" "prod" {
  filter {
    name   = "tag:Name"
    values = ["${upper(var.environment)}*-VPC-EUC1"]
  }
}

//data "aws_subnet_ids" "private" {
//  vpc_id = data.aws_vpc.prod.id
//
//  tags = {
//    Type = "Private*"
//  }
//}

data "aws_subnet_ids" "public" {
  vpc_id = data.aws_vpc.prod.id

  tags = {
    Type = "Public*"
  }
}

