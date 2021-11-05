resource "aws_security_group" "relay" {
  description = "Security group that allows all traffic from the world to a public-facing endpoint"
  name        = "${var.environment}-relay-ec2-pub"
  vpc_id      = data.aws_vpc.cardano.id

  tags = {
    Name = "${var.environment}-relay-pub"
  }
}

resource "aws_security_group_rule" "relay_ingress_public" {
  type      = "ingress"
  from_port = var.relay_node_port
  to_port   = var.relay_node_port
  protocol  = "TCP"
  # todo: change to 0/0
  cidr_blocks       = ["0.0.0.0"]
  security_group_id = aws_security_group.relay.id
  description       = "External traffic to relay port"
}

resource "aws_security_group_rule" "relay_ingress_core" {
  type                     = "ingress"
  from_port                = var.relay_node_port
  to_port                  = var.relay_node_port
  protocol                 = "TCP"
  source_security_group_id = aws_security_group.core.id
  security_group_id        = aws_security_group.relay.id
  description              = "Relay node ingress from core"
}

resource "aws_security_group_rule" "relay_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.relay.id
}

