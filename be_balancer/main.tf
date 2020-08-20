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
#--------------- save be_balancer tfstate to s3 ---------------------------------------------
terraform { 
  backend "s3" {
    bucket = "eschool-proj-tfstate-bucket"
    key    = "Development/be_balancer/terraform.tfstate"
    region = "eu-central-1"
  }
}
#-------------security group for be balancer-------------
resource "aws_security_group" "for_be_balancer" {
  name        = "group_for_be_balancer"
  description = "BE Balancer SG"
  vpc_id      = data.terraform_remote_state.vpc_eschool.outputs.vpc0_id
  dynamic "ingress" {
    for_each = var.allow_ports_balancer
    content {
      description = "Ingress port open"
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
tags = merge(data.terraform_remote_state.vpc_eschool.outputs.common_tags, map("Stage", "${data.terraform_remote_state.vpc_eschool.outputs.stage}"), map("Name", "BE Balancer SG"))
}
#----------------------------instance be balancer----------------------------------------------
resource "aws_instance" "be_balancer" {
  ami           = data.terraform_remote_state.vpc_eschool.outputs.ami.id
  instance_type = var.instance_type
  availability_zone = data.terraform_remote_state.vpc_eschool.outputs.zone_name
  security_groups = [aws_security_group.for_be_balancer.id]
  subnet_id       = data.terraform_remote_state.vpc_eschool.outputs.internal_subnet_id
  private_ip      = var.backend_balancer_priv_ip
  user_data       = file("be_balancer_vm.sh")
  key_name        = "avvppro-Frankfurt-key"
tags = merge(data.terraform_remote_state.vpc_eschool.outputs.common_tags, map("Stage", "${data.terraform_remote_state.vpc_eschool.outputs.stage}"), map("Name", "BE Balancer"))
}
#-----------------------------eip association for BE balancer-----------------------------------
resource "aws_eip_association" "eip_assoc_be" {
  instance_id   = aws_instance.be_balancer.id
  allocation_id = var.allocation_id_be_balancer_ip
}