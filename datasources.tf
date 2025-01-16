data "aws_ssm_parameter" "default_region" {
  name = "defaultRegion"
}

data "aws_ssm_parameter" "state_bucket" {
  name = "iacTerraformStateBucketName"
}