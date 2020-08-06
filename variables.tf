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
    "development" = "eipalloc-05c056dea131007bd"
    "testing"     = "eipalloc-05c056dea131007bd"
    "staging"     = "eipalloc-05c056dea131007bd"
    "production"  = "eipalloc-05c056dea131007bd"
  }
}
variable "allocation_id_fe_balancer_ip" {
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
    "testing"     = "t2.micro"
    "staging"     = "t2.small"
    "production"  = "t2.small"
  }
}
variable "instance_type_fe" {
  default = {
    "development" = "t2.small"
    "testing"     = "t2.small"
    "staging"     = "t2.medium"
    "production"  = "t2.medium"
  }
}
variable "allow_ports_database" {
  type = map
  default = {
    "development" = ["3306", "22"]
    "testing"     = ["3306", "22"]
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
variable "allow_ports_frontend" {
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
    "development" = ["22", "80", "8080"]
    "testing"     = ["22", "80"]
    "staging"     = ["22", "80"]
    "production"  = ["80"]
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
variable "common_tags" {
  type = map
  default = {
    Owner   = "avvppro"
    Project = "eSchool"
  }
}