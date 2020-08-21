#-------------- get vpc data from s3 -----------------------------------------------------
data "terraform_remote_state" "vpc_eschool" { 
  backend = "s3"
  config = {
    bucket = "eschool-proj-tfstate-bucket"
    key    = "Development/vpc/terraform.tfstate"
    region = "eu-central-1"
  }
}
provider "aws" {
  region = data.terraform_remote_state.vpc_eschool.outputs.region
}
#--------------- save frontend tfstate to s3 ---------------------------------------------
terraform { 
  backend "s3" {
    bucket = "eschool-proj-tfstate-bucket"
    key    = "Development/frontend/terraform.tfstate"
    region = "eu-central-1"
  }
}
#-------------security group for frontend-------------
resource "aws_security_group" "for_frontend" {
  name        = "group_for_frontend"
  description = "frontend SG"
  vpc_id      = data.terraform_remote_state.vpc_eschool.outputs.vpc0_id
  dynamic "ingress" {
    for_each = var.allow_ports_frontend
    content {
      description = "Dynamic ingress port open"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" 
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(data.terraform_remote_state.vpc_eschool.outputs.common_tags, map("Stage", "${data.terraform_remote_state.vpc_eschool.outputs.stage}"), map("Name", "Frontend-SG"))
}
#----------------------------instance frontend1----------------------------------------------
resource "aws_instance" "frontend1" {
  ami           = data.terraform_remote_state.vpc_eschool.outputs.ami
  instance_type = var.instance_type
  availability_zone = data.terraform_remote_state.vpc_eschool.outputs.zone_name
  security_groups = [aws_security_group.for_frontend.id]
  subnet_id       = data.terraform_remote_state.vpc_eschool.outputs.internal_subnet_id
  private_ip      = var.frontend1_priv_ip
  user_data       = file("fe_vm.sh")
  key_name        = "avvppro-Frankfurt-key"
 tags = merge(data.terraform_remote_state.vpc_eschool.outputs.common_tags, map("Stage", "${data.terraform_remote_state.vpc_eschool.outputs.stage}"), map("Name", "Frontend1"))
}
#----------------------------instance frontend2----------------------------------------------
resource "aws_instance" "frontend2" {
  ami           = data.terraform_remote_state.vpc_eschool.outputs.ami
  instance_type = var.instance_type
  availability_zone = data.terraform_remote_state.vpc_eschool.outputs.zone_name
  security_groups = [aws_security_group.for_frontend.id]
  subnet_id       = data.terraform_remote_state.vpc_eschool.outputs.internal_subnet_id
  private_ip      = var.frontend2_priv_ip
  user_data       = file("fe_vm.sh")
  key_name        = "avvppro-Frankfurt-key"
 tags = merge(data.terraform_remote_state.vpc_eschool.outputs.common_tags, map("Stage", "${data.terraform_remote_state.vpc_eschool.outputs.stage}"), map("Name", "Frontend2"))
}