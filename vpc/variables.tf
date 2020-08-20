variable "region" {
  default = "eu-central-1"
}
variable "stage" {
   default = "development"
}
variable "vpc0_cidr" {
  default = "192.168.33.0/24"
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