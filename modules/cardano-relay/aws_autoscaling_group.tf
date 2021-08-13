resource "aws_launch_configuration" "relay_launch_config" {
  name_prefix                 = "${upper(var.environment)}-RELAY-NODE-ASG-"
  image_id                    = data.aws_ami.cardano_node.id
  instance_type               = var.ec2_instance_type
  iam_instance_profile        = aws_iam_instance_profile.relay_node_profile.name
  security_groups             = [var.node_security_group_id]
  associate_public_ip_address = true
  key_name                    = var.ec2_key_name
  user_data = templatefile("${path.module}/templates/cloud_init_relay.sh", {
    hostname_prefix  = "relay"
    count            = "0"
    private_dns_zone = "private"
    eip              = aws_eip.cardano_node[0].id
    eip_ip4          = aws_eip.cardano_node[0].public_ip
    region           = data.aws_region.current.name
    relay_node_port  = var.node_port
    environment      = var.environment
  })

  root_block_device {
    volume_size = var.relay_root_disk_size
    volume_type = "gp2"
  }

  lifecycle {
    ignore_changes        = [root_block_device]
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "rely_node" {
  name                 = "${upper(var.environment)}-RELAY-NODE-ASG"
  launch_configuration = aws_launch_configuration.relay_launch_config.name
  vpc_zone_identifier  = data.aws_subnet_ids.public.ids
  min_size             = var.asg_min_size
  max_size             = var.asg_max_size
  desired_capacity     = var.asg_desired_capacity

  lifecycle {
    create_before_destroy = true
  }

  tags = flatten(["${data.null_data_source.asg_tags.*.outputs}",
    map("key", "Name", "value", "${upper(var.environment)}-RELAY-NODE-EC2-ASG", "propagate_at_launch", true),
    map("key", "AWSInspectorEnabled", "value", "true", "propagate_at_launch", true)
  ])
}
