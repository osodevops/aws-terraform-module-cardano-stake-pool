module "tableau_backup_bucket" {
  source                              = "git::ssh://git@github.com/osodevops/aws-terraform-module-s3.git"
  s3_bucket_name                      =   local.s3_backup_bucket_name
  s3_bucket_policy                    = ""
  s3_bucket_force_destroy             = false
  s3_sse_algorithm                    = "aws/s3"
  bucket_versioning                   = true
  current_ia_transition_days          = 30
  current_glacier_transition_days     = 60
  noncurrent_ia_transition_days       = 30
  noncurrent_glacier_transition_days  = 60
  block_public_acls                   = true
  block_public_policy                 = true
  ignore_public_acls                  = true
  restrict_public_buckets             = true
  common_tags                         = var.common_tags
}