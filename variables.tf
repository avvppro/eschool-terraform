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
  default = {
    "development" = "eipalloc-0005839cfbe62d860"
    "testing"     = "eipalloc-0005839cfbe62d860"
    "staging"     = "eipalloc-0005839cfbe62d860"
    "production"  = "eipalloc-0005839cfbe62d860"
  }
}

variable "instance_type" {
  default = {
    "development" = "t2.micro"
    "testing"     = "t3.micro"
    "staging"     = "t2.small"
    "production"  = "t3.small"
  }
}
variable "allow_ports_database" {
  type = map
  default = {
    "development" = ["22", "3306"]
    "testing"     = ["22", "3306"]
    "staging"     = ["3306"]
    "production"  = ["3306"]
  }
}
variable "allow_ports_backend" {
  type = map
  default = {
    "development" = ["22", "8080"]
    "testing"     = ["22", "8080"]
    "staging"     = ["8080"]
    "production"  = ["8080"]
  }
}
variable "allow_ports_proxy" {
  type = map
  default = {
    "development" = ["22", "80", "8080"]
    "testing"     = ["22", "80"]
    "staging"     = ["80"]
    "production"  = ["80"]
  }
}
variable "allow_cidr_blocks" {
  type = map
  default = {
    "development" = ["0.0.0.0/0"]
    "testing"     = ["0.0.0.0/0"]
    "staging"     = ["192.168.0.0/16"]
    "production"  = ["192.168.0.0/16"]
  }
}
variable "get_pub_ip_vpc0" {
  type = map
  default = {
    "development" = true
    "testing"     = true
    "staging"     = false
    "production"  = false
  }
}
variable "vpc0_cidr" {
  default = "192.168.33.0/24"
}
variable "internal_acc_cidr" {
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
variable "backend_proxy_priv_ip" {
  default = "192.168.33.150"
}
variable "common_tags" {
  type = map
  default = {
    Owner   = "avvppro"
    Project = "eSchool"
  }
}