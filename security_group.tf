#-------------security group for database-------------
resource "aws_security_group" "for_database" {
  name        = "group_for_database"
  description = "database SG"
  vpc_id      = aws_vpc.vpc0.id
  dynamic "ingress" { #dynamic block creation for ingress connection
    for_each = lookup(var.allow_ports_database, var.stage)
    content {
      description = "Dynamic ingress port open"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = lookup(var.allow_cidr_blocks, var.stage)
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
    for_each = lookup(var.allow_ports_backend, var.stage)
    content {
      description = "Dynamic ingress port open"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = lookup(var.allow_cidr_blocks, var.stage)
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
#-------------security group for proxy-------------
resource "aws_security_group" "for_proxy" {
  name        = "group_for_proxy"
  description = "proxy SG"
  vpc_id      = aws_vpc.vpc0.id
  dynamic "ingress" {
    for_each = lookup(var.allow_ports_proxy, var.stage)
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
  tags = merge(var.common_tags, map("Stage", "${var.stage}"), map("Name", "Proxy-SG"))
}
#-------------security group for frontend-------------
resource "aws_security_group" "for_frontend" {
  name        = "group_for_frontend"
  description = "frontend SG"
  vpc_id      = aws_vpc.vpc0.id
  dynamic "ingress" {
    for_each = lookup(var.allow_ports_frontend, var.stage)
    content {
      description = "Dynamic ingress port open"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = lookup(var.allow_cidr_blocks, var.stage)
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