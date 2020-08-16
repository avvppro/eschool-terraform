variable "region" {
  default = "eu-central-1"
}
variable "stage" {
  default = "development"
  # default = "testing"
  # default = "staging"
  # default = "production"
}
variable "allocation_id_be_balancer_ip" {
  default =  "eipalloc-090cd36d3c083b996"
}
variable "allocation_id_fe_balancer_ip" {
  default =  "eipalloc-026262fb6b7bc7208"
}
variable "allocation_id_bamboo_ip" {
  default =  "eipalloc-033753e44c42dbe5a"
}

variable "instance_type" {
  default = {
    "development" = "t2.micro"
    "testing"     = "t2.micro"
    "staging"     = "t3.micro"
    "production"  = "t3.micro"
  }
}
variable "instance_type_bamboo" {
  default = {
    "development" = "t2.medium"
    "testing"     = "t2.small"
    "staging"     = "t3.small"
    "production"  = "t3.small"
  }
}
variable "allow_ports_database" {
  default =  ["22", "3306"]
}
variable "allow_ports_backend" {
  default =  ["22", "8080"]
}
variable "allow_ports_frontend" {
  default =  ["22", "80"]
}
variable "allow_ports_balancer" {
  default =  ["22", "80", "443"]
}
variable "allow_ports_bamboo" {
  default =  ["22", "80", "443"]
}
variable "vpc0_cidr" {
  default = "192.168.33.0/24"
}
variable "database_priv_ip" {
  default = "192.168.33.11"
}
variable "backend1_priv_ip" {
  default = "192.168.33.51"
}
variable "backend2_priv_ip" {
  default = "192.168.33.52"
}
variable "backend_balancer_priv_ip" {
  default = "192.168.33.150"
}
variable "frontend1_priv_ip" {
  default = "192.168.33.201"
}
variable "frontend2_priv_ip" {
  default = "192.168.33.202"
}
variable "frontend_balancer_priv_ip" {
  default = "192.168.33.250"
}
variable "bamboo_priv_ip" {
  default = "192.168.33.251"
}
variable "common_tags" {
  type = map
  default = {
    Owner   = "avvppro"
    Project = "eSchool"
  }
}