variable "instance_type" {
  default = "t2.micro"
 }
variable "allow_ports_backend" {
  default =  ["22", "8080"]
}
variable "backend1_priv_ip" {
  default = "192.168.33.51"
}
variable "backend2_priv_ip" {
  default = "192.168.33.52"
}