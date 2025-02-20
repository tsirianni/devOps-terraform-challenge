locals {
  /*
    This resources should only be managed/created in the default workspace, for that we have to control the count
    by verifying the current workspace. By doing that, when running `terraform play/apply` in another workspace, it will
    NOT try to create these resources again and associate them with other workspace's states.
   */
  resource_count   = terraform.workspace == "default" ? 1 : 0

  # Dev environment variables setup
  dev_env_file_content = data.aws_s3_object.dev_env_file.body
  dev_env_lines        = split("\n", local.dev_env_file_content)
  dev_env = {
    for line in local.dev_env_lines :
    trimspace(split("=", line)[0]) => trimspace(replace(split("=", line)[1], "^\\\"|\\\"$", "")) # Strip leading and trailing quotes
    if line != "" && !startswith(line, "#")
  }

  # Staging environment variables setup
  staging_env_file_content = data.aws_s3_object.staging_env_file.body
  staging_env_lines        = split("\n", local.staging_env_file_content)
  staging_env = {
    for line in local.staging_env_lines :
    trimspace(split("=", line)[0]) => trimspace(replace(split("=", line)[1], "^\\\"|\\\"$", ""))
    if line != "" && !startswith(line, "#")
  }
}

resource "aws_s3_bucket" "terraform_state_bucket" {
  count  = local.resource_count
  bucket = data.aws_ssm_parameter.state_bucket.value

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Iac     = true
    IacTool = "Terraform"
  }

  tags_all = {
    Iac     = true
    IacTool = "Terraform"
  }
}

resource "aws_s3_bucket_versioning" "terraform_state_bucket_versioning" {
  count = local.resource_count

  bucket = aws_s3_bucket.terraform_state_bucket[count.index].bucket # Correctly reference the bucket with count.index

  depends_on = [aws_s3_bucket.terraform_state_bucket]

  versioning_configuration {
    status = "Enabled"
  }
}

# VPCs config
module "dev_vpc" {
  source                    = "./modules/vpc"
  vpc_cidr_block            = local.dev_env["vpc_cidr_block"]
  private_subnet_cidr_block = local.dev_env["private_subnet_cidr_block"]
  public_subnet_cidr_block  = local.dev_env["public_subnet_cidr_block"]
  env                       = local.dev_env["name"]
}

module "staging_vpc" {
  source                    = "./modules/vpc"
  vpc_cidr_block            = local.staging_env["vpc_cidr_block"]
  private_subnet_cidr_block = local.staging_env["private_subnet_cidr_block"]
  public_subnet_cidr_block  = local.staging_env["public_subnet_cidr_block"]
  env                       = local.staging_env["name"]
}