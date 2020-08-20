variable "instance_type" {
  default = "t2.micro"
 }
variable "allow_ports_balancer" {
  default =  ["22", "80", "443"]
}
variable "backend1_priv_ip" {
  default = "192.168.33.51"
}
variable "backend_balancer_priv_ip" {
  default = "192.168.33.150"
}
variable "allocation_id_be_balancer_ip" {
  default =  "eipalloc-090cd36d3c083b996"
}