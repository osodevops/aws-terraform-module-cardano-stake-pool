module "ssm-session-manager" {
source                              = "git::ssh://git@github.com/osodevops/aws-terraform-module-ssm-session-manager.git"
  s3_bucket_name                    = local.ssm_s3_bucket_name
  s3_key_prefix                     = "logs"
  s3_encryption_enabled             = true
  s3_bucket_force_destroy           = false
  bucket_versioning                 = false
  kms_alias                         = "aws/s3"
  cloudwatch_log_group_name         = local.cloudwatch_log_group_name
  cloudwatch_encryption_enabled     = false
  common_tags                       = var.common_tags
}