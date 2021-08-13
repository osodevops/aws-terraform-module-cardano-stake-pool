resource "aws_launch_configuration" "cardano_core_node" {
  name_prefix                 = "cardano-${var.environment}-cire-node-"
  image_id                    = data.aws_ami.cardano_node.id
  instance_type               = var.ec2_instance_type
  iam_instance_profile        = aws_iam_instance_profile.core_node_profile.name
  security_groups             = [var.node_security_group_id]
  associate_public_ip_address = false
  key_name                    = var.ec2_key_name
  user_data = templatefile("${path.module}/templates/cloud_init_core.sh", {
    hostname_prefix  = "core"
    count            = "0"
    private_dns_zone = "private"
    region           = data.aws_region.current.name
    core_node_port   = var.node_port
    environment      = var.environment
  })

  root_block_device {
    volume_size = var.node_root_disk_size
    volume_type = "gp2"
  }

  lifecycle {
    ignore_changes        = [root_block_device]
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "core_node" {
  name                 = "cardano-${var.environment}-core-nodes"
  launch_configuration = aws_launch_configuration.cardano_core_node.name
  vpc_zone_identifier  = data.aws_subnet_ids.private.ids
  min_size             = var.asg_min_size
  max_size             = var.asg_max_size
  desired_capacity     = var.asg_desired_capacity

  lifecycle {
    create_before_destroy = true
  }

  tags = concat(
    null_resource.asg_tags.*.triggers,
    [
      { key : "Name", value : "cardano-${var.environment}-core-node", propagate_at_launch : true },
      { key : "Environment", value : var.environment, propagate_at_launch : true },
      { key : "Node", value : "core", propagate_at_launch : true },
      { key : "AWSInspectorEnabled", value : "true", propagate_at_launch : true }
  ])
}
