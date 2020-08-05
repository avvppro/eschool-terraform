#------------------network creation--------------------------------------------------
resource "aws_vpc" "vpc0" {
  cidr_block = var.vpc0_cidr
  tags       = merge(var.common_tags, map("Stage", "${var.stage}"), map("Name", "my vpc0"))
}
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

resource "aws_subnet" "internal_access" {
  vpc_id                  = aws_vpc.vpc0.id
  map_public_ip_on_launch = lookup(var.get_pub_ip_vpc0, var.stage)
  cidr_block              = var.internal_acc_cidr
  availability_zone       = data.aws_availability_zones.available.names[0]
  tags                    = merge(var.common_tags, map("Stage", "${var.stage}"), map("Name", "subnet for zone 0"))
}
#-----------------------------eip association for BE balancer-----------------------------------
resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.be_balancer.id
  allocation_id = lookup(var.allocation_id_be_balancer_ip, var.stage)
}