data "aws_ssm_parameter" "default_region" {
  name = "defaultRegion"
}

data "aws_ssm_parameter" "state_bucket" {
  name = "iacTerraformStateBucketName"
}

data "aws_s3_object" "dev_env_file" {
  bucket = data.aws_ssm_parameter.state_bucket.value
  key    = var.dev_env_file_key
}

data "aws_s3_object" "staging_env_file" {
  bucket = data.aws_ssm_parameter.state_bucket.value
  key    = var.staging_env_file_key
}