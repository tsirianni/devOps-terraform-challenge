resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Iac     = true
    IacTool = "Terraform"
  }

  tags_all = {
    Iac     = true
    IacTool = "Terraform"
  }
}

resource "aws_subnet" "main_private" {
  vpc_id     = aws_vpc.main.id
  depends_on = [aws_vpc.main]
  cidr_block = var.private_subnet_cidr_block

  tags = {
    Iac     = true
    IacTool = "Terraform"
    SubnetType = "Private"
  }

  tags_all = {
    Iac     = true
    IacTool = "Terraform"
    SubnetType = "Private"
  }
}

resource "aws_subnet" "main_public" {
  vpc_id     = aws_vpc.main.id
  depends_on = [aws_vpc.main]
  cidr_block = var.public_subnet_cidr_block

  tags = {
    Iac     = true
    IacTool = "Terraform"
    SubnetType = "Public"
  }

  tags_all = {
    Iac     = true
    IacTool = "Terraform"
    SubnetType = "Public"
  }
}