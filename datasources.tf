data "aws_ssm_parameter" "default_region" {
  name = "defaultRegion"
}

data "aws_ssm_parameter" "state_bucket" {
  name = "iacTerraformStateBucketName"
}

data "aws_s3_object" "env_file" {
  bucket = data.aws_ssm_parameter.state_bucket.value
  key    = var.env_file_key
}