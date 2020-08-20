# Declare a region. Using availiability zones 0 and 1.
# Creating vpc, internet gateway, routing table, custom subnet.
# Save .tfstate into aws s3 bucket from region eu-central-1
provider "aws" {
  region = var.region
}
#--------------- save tfstate to s3 -------------------------------------------------
terraform {
  backend "s3" {
    bucket = "eschool-proj-tfstate-bucket"
    key    = "Development/vpc/terraform.tfstate"
    region = "eu-central-1"
  }
}
#---------------------------ami image -----------------------------------------------------
data "aws_ami" "latest_amazon_linux" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}
#------------------network creation--------------------------------------------------
resource "aws_vpc" "vpc0" {
  cidr_block = var.vpc0_cidr
  tags       = merge(var.common_tags, map("Stage", "${var.stage}"), map("Name", "eschool vpc0"))
}
data "aws_availability_zones" "available" {}
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc0.id
  tags   = merge(var.common_tags, map("Stage", "${var.stage}"), map("Name", "Internet GW for vpc0"))
}
resource "aws_route_table" "route0" {
  vpc_id = aws_vpc.vpc0.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = merge(var.common_tags, map("Stage", "${var.stage}"), map("Name", "route table vpc0+igw0"))
}
resource "aws_main_route_table_association" "a" {
  vpc_id         = aws_vpc.vpc0.id
  route_table_id = aws_route_table.route0.id
}

resource "aws_subnet" "internal" {
  vpc_id                  = aws_vpc.vpc0.id
  map_public_ip_on_launch = true
  cidr_block              = var.vpc0_cidr
  availability_zone       = data.aws_availability_zones.available.names[0]
  tags                    = merge(var.common_tags, map("Stage", "${var.stage}"), map("Name", "eschool internal subnet"))
}

