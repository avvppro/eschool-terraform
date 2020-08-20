#-------------security group for database-------------
resource "aws_security_group" "for_database" {
  name        = "group_for_database"
  description = "database SG"
  vpc_id      = aws_vpc.vpc0.id
  dynamic "ingress" { #dynamic block creation for ingress connection
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
    protocol    = "-1" # -1 means any protocol
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(var.common_tags, map("Stage", "${var.stage}"), map("Name", "Database-SG"))
}
#-------------security group for backend-------------
resource "aws_security_group" "for_backend" {
  name        = "group_for_backend"
  description = "backend SG"
  vpc_id      = aws_vpc.vpc0.id
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
  tags = merge(var.common_tags, map("Stage", "${var.stage}"), map("Name", "Backend-SG"))
}
<<<<<<< HEAD
#-------------security group for be balancer-------------
resource "aws_security_group" "for_be_balancer" {
  name        = "group_for_be_balancer"
  description = "be_balancer SG"
  vpc_id      = aws_vpc.vpc0.id
  dynamic "ingress" {
    for_each = lookup(var.allow_ports_be_balancer, var.stage)
=======
#-------------security group for  balancer-------------
resource "aws_security_group" "for_balancer" {
  name        = "group_for_balancer"
  description = "Balancer SG"
  vpc_id      = aws_vpc.vpc0.id
  dynamic "ingress" {
    for_each = var.allow_ports_balancer
>>>>>>> bambooCI
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
<<<<<<< HEAD
  tags = merge(var.common_tags, map("Stage", "${var.stage}"), map("Name", "BE-balancer-SG"))
=======
  tags = merge(var.common_tags, map("Stage", "${var.stage}"), map("Name", "Balancer-SG"))
>>>>>>> bambooCI
}
#-------------security group for frontend-------------
resource "aws_security_group" "for_frontend" {
  name        = "group_for_frontend"
  description = "frontend SG"
  vpc_id      = aws_vpc.vpc0.id
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
  tags = merge(var.common_tags, map("Stage", "${var.stage}"), map("Name", "Frontend-SG"))
}
<<<<<<< HEAD
#-------------security group for fe balancer-------------
resource "aws_security_group" "for_fe_balancer" {
  name        = "group_for_fe_balancer"
  description = "fe_balancer SG"
  vpc_id      = aws_vpc.vpc0.id
  dynamic "ingress" {
    for_each = lookup(var.allow_ports_fe_balancer, var.stage)
    content {
      description = "Ingress port open"
=======
#-------------security group for bamboo-------------
resource "aws_security_group" "for_bamboo" {
  name        = "group_for_bamboo"
  description = "bamboo SG"
  vpc_id      = aws_vpc.vpc0.id
  dynamic "ingress" {
    for_each = var.allow_ports_bamboo
    content {
      description = "Dynamic ingress port open"
>>>>>>> bambooCI
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
<<<<<<< HEAD
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(var.common_tags, map("Stage", "${var.stage}"), map("Name", "FE-balancer-SG"))
=======
    protocol    = "-1" 
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(var.common_tags, map("Stage", "${var.stage}"), map("Name", "Bamboo-SG"))
>>>>>>> bambooCI
}