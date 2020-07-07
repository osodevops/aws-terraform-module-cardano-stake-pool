resource "aws_security_group" "relay_sg" {
  description = "Security group that allows all traffic from mainnet to relay"
  name        = "${upper(var.environment)}-RELAY-PUB-SG"
  vpc_id      = data.aws_vpc.prod.id

  tags = {
    Name = "${upper(var.environment)}-RELAY-PUB-SG"
  }
}

resource "aws_security_group_rule" "relay-sg-ingress-3000" {
  type              = "ingress"
  from_port         = var.relay_node_port
  to_port           = var.relay_node_port
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.relay_sg.id
  description       = "External traffic from Mainnet"
}

resource "aws_security_group_rule" "relay-ssh-ingress-22" {
  from_port         = 22
  protocol          = "TCP"
  to_port           = 22
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.relay_sg.id
}

resource "aws_security_group_rule" "relay-sg-egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.relay_sg.id
}

