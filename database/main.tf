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
#--------------- save database tfstate to s3 ---------------------------------------------
terraform { 
  backend "s3" {
    bucket = "eschool-proj-tfstate-bucket"
    key    = "Development/database/terraform.tfstate"
    region = "eu-central-1"
  }
}
#------------------ security group for database-------------------------------------------
resource "aws_security_group" "for_database" {
  name        = "group_for_database"
  description = "database SG"
  vpc_id      = data.terraform_remote_state.vpc_eschool.outputs.vpc0_id
  dynamic "ingress" { 
    for_each = var.allow_ports_database
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
  tags = merge(data.terraform_remote_state.vpc_eschool.outputs.common_tags, map("Stage", "${data.terraform_remote_state.vpc_eschool.outputs.stage}"), map("Name", "Database-SG"))
}
#----------------------------instance database----------------------------------------------
resource "aws_instance" "database" {
  ami           = data.terraform_remote_state.vpc_eschool.outputs.ami.id
  instance_type = var.instance_type
  availability_zone = data.terraform_remote_state.vpc_eschool.outputs.zone_name
  security_groups = [aws_security_group.for_database.id]
  subnet_id       = data.terraform_remote_state.vpc_eschool.outputs.internal_subnet_id
  private_ip      = var.database_priv_ip
  user_data       = file("db_vm.sh")
    key_name        = "avvppro-Frankfurt-key"
  tags = merge(data.terraform_remote_state.vpc_eschool.outputs.common_tags, map("Stage", "${data.terraform_remote_state.vpc_eschool.outputs.stage}"), map("Name", "Database"))
}