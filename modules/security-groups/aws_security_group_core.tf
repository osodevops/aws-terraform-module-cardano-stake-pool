resource "aws_security_group" "core" {
  description = "Security group that allows all traffic from mainnet to core"
  name        = "${upper(var.environment)}-CORE-PRI-SG"
  vpc_id      = data.aws_vpc.cardano.id

  tags = {
    Name = "${upper(var.environment)}-CORE-PRI-SG"
  }
}

resource "aws_security_group_rule" "core_ingress_relay" {
  type                     = "ingress"
  from_port                = var.core_node_port
  to_port                  = var.core_node_port
  protocol                 = "TCP"
  source_security_group_id = aws_security_group.relay.id
  security_group_id        = aws_security_group.core.id
  description              = "Core nodes ingress from relay"
}

resource "aws_security_group_rule" "core_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.core.id
}
