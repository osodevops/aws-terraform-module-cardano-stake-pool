variable "environment" {
  type = string
}

variable "common_tags" {
  type = "map"
}

locals {
  s3_backup_bucket_name = "${data.aws_caller_identity.current.account_id}-${var.environment}-${data.aws_region}-cardano-backup"
  ssm_s3_bucket_name = "${data.aws_caller_identity.current.account_id}-${data.aws_region}-session-logs"
  cloudwatch_log_group_name = "${data.aws_caller_identity.current.account_id}-${data.aws_region}-session-logs"
}