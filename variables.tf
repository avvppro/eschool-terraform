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
    "staging"     = "t2.small"
    "production"  = "t2.small"
<<<<<<< HEAD
  }
}
variable "instance_type_fe" {
  default = {
    "development" = "t2.small"
    "testing"     = "t2.small"
    "staging"     = "t2.medium"
    "production"  = "t2.medium"
=======
>>>>>>> bambooCI
  }
}
variable "instance_type_bamboo" {
  default = "t2.medium"
}
variable "allow_ports_database" {
<<<<<<< HEAD
  type = map
  default = {
    "development" = ["3306", "22"]
    "testing"     = ["3306", "22"]
    "staging"     = ["3306"]
    "production"  = ["3306"]
  }
=======
  default =  ["22", "3306"]
>>>>>>> bambooCI
}
variable "allow_ports_backend" {
  default =  ["22", "8080"]
}
variable "allow_ports_frontend" {
<<<<<<< HEAD
  type = map
  default = {
    "development" = ["80", "443", "22"]
    "testing"     = ["80", "443", "22"]
    "staging"     = ["80", "443"]
    "production"  = ["80", "443"]
  }
}
variable "allow_ports_be_balancer" {
  type = map
  default = {
    "development" = ["22", "80", "8080", "443"]
    "testing"     = ["22", "80", "443"]
    "staging"     = ["22", "80", "443"]
    "production"  = ["80", "443"]
  }
}
variable "allow_ports_fe_balancer" {
  type = map
  default = {
    "development" = ["22", "80", "443"]
    "testing"     = ["22", "80", "443"]
    "staging"     = ["22", "80", "443"]
    "production"  = ["80", "443"]
  }
}
variable "allow_cidr_blocks" {
  type = map
  default = {
    "development" = ["0.0.0.0/0"]
    "testing"     = ["0.0.0.0/0"]
    "staging"     = ["0.0.0.0/0"]
    "production"  = ["0.0.0.0/0"]
  }
}
variable "get_pub_ip_vpc0" {
  type = map
  default = {
    "development" = true
    "testing"     = true
    "staging"     = true
    "production"  = true
  }
=======
  default =  ["22", "80"]
}
variable "allow_ports_balancer" {
  default =  ["22", "80", "443"]
}
variable "allow_ports_bamboo" {
  default =  ["22", "80", "443", "8085"]
>>>>>>> bambooCI
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