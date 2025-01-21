resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Iac     = true
    IacTool = "Terraform"
    Name    = "${var.env}-vpc"
  }

  tags_all = {
    Iac     = true
    IacTool = "Terraform"
    Name    = "${var.env}-vpc"
  }
}

resource "aws_subnet" "main_private" {
  vpc_id     = aws_vpc.main.id
  depends_on = [aws_vpc.main]
  cidr_block = var.private_subnet_cidr_block

  tags = {
    Iac        = true
    IacTool    = "Terraform"
    SubnetType = "Private"
    Name       = "${var.env}-private-subnet"
  }

  tags_all = {
    Iac        = true
    IacTool    = "Terraform"
    SubnetType = "Private"
    Name       = "${var.env}-private-subnet"
  }
}

resource "aws_subnet" "main_public" {
  vpc_id     = aws_vpc.main.id
  depends_on = [aws_vpc.main]
  cidr_block = var.public_subnet_cidr_block

  tags = {
    Iac        = true
    IacTool    = "Terraform"
    SubnetType = "Public"
    Name       = "${var.env}-public-subnet"
  }

  tags_all = {
    Iac        = true
    IacTool    = "Terraform"
    SubnetType = "Public"
    Name       = "${var.env}-public-subnet"
  }
}