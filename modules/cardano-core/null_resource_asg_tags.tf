resource "null_resource" "asg_tags" {
  count = length(keys(var.common_tags))

  triggers = {
    key                 = keys(var.common_tags)[count.index]
    value               = values(var.common_tags)[count.index]
    propagate_at_launch = true
  }
}
