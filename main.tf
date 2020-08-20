provider "aws" {
  region = var.region
}
#-----------------data---------------------------------------------------------
data "aws_availability_zones" "available" {}
data "aws_ami" "latest_amazon_linux" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

#----------------------------instance database----------------------------------------------
resource "aws_instance" "database" {
  ami           = data.aws_ami.latest_amazon_linux.id
  instance_type = lookup(var.instance_type, var.stage) 
  availability_zone = data.aws_availability_zones.available.names[0]
  security_groups = [aws_security_group.for_database.id]
  subnet_id       = aws_subnet.internal.id
  private_ip      = var.database_priv_ip
  user_data       = file("db_vm.sh")
    key_name        = "avvppro-Frankfurt-key"
  tags = merge(var.common_tags, map("Stage", "${var.stage}"), map("Name", "Database"))
}
#----------------------------instance backend1----------------------------------------------
resource "aws_instance" "backend1" {
  ami           = data.aws_ami.latest_amazon_linux.id
  instance_type = lookup(var.instance_type, var.stage) 
  availability_zone = data.aws_availability_zones.available.names[0]
  security_groups = [aws_security_group.for_backend.id]
  subnet_id       = aws_subnet.internal.id
  private_ip      = var.backend1_priv_ip
  user_data       = file("be_vm.sh")
  key_name        = "avvppro-Frankfurt-key"
  tags = merge(var.common_tags, map("Stage", "${var.stage}"), map("Name", "Backend1"))

}/*
#----------------------------instance backend2----------------------------------------------
resource "aws_instance" "backend2" {
  ami           = data.aws_ami.latest_amazon_linux.id
  instance_type = lookup(var.instance_type, var.stage) 
  availability_zone = data.aws_availability_zones.available.names[0]
  security_groups = [aws_security_group.for_backend.id]
  subnet_id       = aws_subnet.internal.id
  private_ip      = var.backend2_priv_ip
  user_data       = file("be_vm.sh")
  key_name        = "avvppro-Frankfurt-key"
  tags = merge(var.common_tags, map("Stage", "${var.stage}"), map("Name", "Backend2"))

}*/
#----------------------------instance be balancer----------------------------------------------
resource "aws_instance" "be_balancer" {
  ami           = data.aws_ami.latest_amazon_linux.id
  instance_type = lookup(var.instance_type, var.stage) 
  availability_zone = data.aws_availability_zones.available.names[0]
  security_groups = [aws_security_group.for_balancer.id]
  subnet_id       = aws_subnet.internal.id
  private_ip      = var.backend_balancer_priv_ip
  user_data       = file("be_balancer_vm.sh")
  key_name        = "avvppro-Frankfurt-key"
  tags = merge(var.common_tags, map("Stage", "${var.stage}"), map("Name", "BE-balancer"))
}
#----------------------------instance frontend1----------------------------------------------
resource "aws_instance" "frontend1" {
  ami           = data.aws_ami.latest_amazon_linux.id
  instance_type = lookup(var.instance_type, var.stage)
  availability_zone = data.aws_availability_zones.available.names[0]
  security_groups = [aws_security_group.for_frontend.id]
  subnet_id       = aws_subnet.internal.id
  private_ip      = var.frontend1_priv_ip
  user_data       = file("fe_vm.sh")
  key_name        = "avvppro-Frankfurt-key"
  tags = merge(var.common_tags, map("Stage", "${var.stage}"), map("Name", "Frontend1"))

}/*
#----------------------------instance frontend2----------------------------------------------
resource "aws_instance" "frontend2" {
  ami           = data.aws_ami.latest_amazon_linux.id
  instance_type = lookup(var.instance_type, var.stage)
  availability_zone = data.aws_availability_zones.available.names[0]
  security_groups = [aws_security_group.for_frontend.id]
  subnet_id       = aws_subnet.internal.id
  private_ip      = var.frontend2_priv_ip
  user_data       = file("fe_vm.sh")
  key_name        = "avvppro-Frankfurt-key"
  tags = merge(var.common_tags, map("Stage", "${var.stage}"), map("Name", "Frontend2"))

}*/
#----------------------------instance fe balancer----------------------------------------------
resource "aws_instance" "fe_balancer" {
  ami           = data.aws_ami.latest_amazon_linux.id
  instance_type = lookup(var.instance_type, var.stage) 
  availability_zone = data.aws_availability_zones.available.names[0]
  security_groups = [aws_security_group.for_balancer.id]
  subnet_id       = aws_subnet.internal.id
  private_ip      = var.frontend_balancer_priv_ip
  user_data       = file("fe_balancer_vm.sh")
  key_name        = "avvppro-Frankfurt-key"
  tags = merge(var.common_tags, map("Stage", "${var.stage}"), map("Name", "FE-balancer"))
}
#----------------------------instance bamboo----------------------------------------------
resource "aws_instance" "bamboo" {
  ami           = data.aws_ami.latest_amazon_linux.id
  instance_type = var.instance_type_bamboo
  availability_zone = data.aws_availability_zones.available.names[0]
  security_groups = [aws_security_group.for_bamboo.id]
  subnet_id       = aws_subnet.internal.id
  private_ip      = var.bamboo_priv_ip
  user_data       = file("bamboo_vm.sh")
  key_name        = "avvppro-Frankfurt-key"
  tags = merge(var.common_tags, map("Stage", "${var.stage}"), map("Name", "Bamboo"))
}
