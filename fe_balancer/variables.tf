variable "instance_type" {
  default = "t2.micro"
 }
variable "allow_ports_balancer" {
  default =  ["22", "80", "443"]
}
variable "frontend_balancer_priv_ip" {
  default = "192.168.33.250"
}
variable "allocation_id_fe_balancer_ip" {
  default =  "eipalloc-026262fb6b7bc7208"
}