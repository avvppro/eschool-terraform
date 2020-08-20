variable "instance_type" {
  default = "t2.micro"
 }
variable "allow_ports_frontend" {
  default =  ["22", "80"]
}
variable "frontend1_priv_ip" {
  default = "192.168.33.201"
}
variable "frontend2_priv_ip" {
  default = "192.168.33.202"
}