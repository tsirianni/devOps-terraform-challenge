# devOps-terraform-challenge

This is my proposed solution for the terraform challenge on Rocketseat's DevOps' path.

## Structure of modules

The modules were structured inside the directory `/modules` by **resource**, such as vpc, load-balancer and ec2. Inside these modules there is only 1 definition for each resource in order to avoid code duplicity and some key values (such as CIDR blocks for the VPC and subnets) are obtained through variables.

## Managing resources

There is a main datasource file at the root of the project which exposes the content of an s3 object and the key for such object is obtained through a variable passed in the CLI command. The s3 object is an env file, containing the definitions for the sensitive values used in the environment. Along with the terraform.tfstate file, the bucket also stores one of these env files for each environment, e.g. **dev.env**, **staging.env**, and so on.

This files should be constructed as suggested by the `example.env` file.

### Modifying resources

To actually execute the terraform commands to manage the infrastructure, it is necessary to inform which env file is being used. For such, each command should have a var added as such: `terraform plan -var="env_file_key=dev.env"`. Without specifying the **env_file_key** variable it is not possible to plan and apply changes to the infrastructure.
