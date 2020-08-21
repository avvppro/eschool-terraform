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
#--------------- save backend tfstate to s3 ---------------------------------------------
terraform { 
  backend "s3" {
    bucket = "eschool-proj-tfstate-bucket"
    key    = "Development/backend/terraform.tfstate"
    region = "eu-central-1"
  }
}
#-------------security group for backend-------------
resource "aws_security_group" "for_backend" {
  name        = "group_for_backend"
  description = "backend SG"
  vpc_id      = data.terraform_remote_state.vpc_eschool.outputs.vpc0_id
  dynamic "ingress" {
    for_each = var.allow_ports_backend
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
  tags = merge(data.terraform_remote_state.vpc_eschool.outputs.common_tags, map("Stage", "${data.terraform_remote_state.vpc_eschool.outputs.stage}"), map("Name", "Backend-SG"))
}
#----------------------------instance backend1----------------------------------------------
resource "aws_instance" "backend1" {
  ami           = data.terraform_remote_state.vpc_eschool.outputs.ami
  instance_type = var.instance_type
  availability_zone = data.terraform_remote_state.vpc_eschool.outputs.zone_name
  security_groups = [aws_security_group.for_backend.id]
  subnet_id       = data.terraform_remote_state.vpc_eschool.outputs.internal_subnet_id
  private_ip      = var.backend1_priv_ip
  user_data       = file("be_vm.sh")
  key_name        = "avvppro-Frankfurt-key"
  tags = merge(data.terraform_remote_state.vpc_eschool.outputs.common_tags, map("Stage", "${data.terraform_remote_state.vpc_eschool.outputs.stage}"), map("Name", "Backend1"))
}
#----------------------------instance backend2----------------------------------------------
resource "aws_instance" "backend2" {
  ami           = data.terraform_remote_state.vpc_eschool.outputs.ami
  instance_type = var.instance_type 
  availability_zone = data.terraform_remote_state.vpc_eschool.outputs.zone_name
  security_groups = [aws_security_group.for_backend.id]
  subnet_id       = data.terraform_remote_state.vpc_eschool.outputs.internal_subnet_id
  private_ip      = var.backend2_priv_ip
  user_data       = file("be_vm.sh")
  key_name        = "avvppro-Frankfurt-key"
  tags = merge(data.terraform_remote_state.vpc_eschool.outputs.common_tags, map("Stage", "${data.terraform_remote_state.vpc_eschool.outputs.stage}"), map("Name", "Backend2"))
}
