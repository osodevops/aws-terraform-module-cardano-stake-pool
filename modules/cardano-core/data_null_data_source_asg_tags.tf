data "null_data_source" "asg_tags" {
  count = "${length(keys(var.common_tags))}"

  inputs = {
    key                 = element(keys(var.common_tags), count.index)
    value               = element(values(var.common_tags), count.index)
    propagate_at_launch = true
  }
}