variable "instance_type_bamboo" {
  default = "t2.medium"
 }
variable "allow_ports_bamboo" {
  default =  ["22", "80", "443", "8085"]
}
variable "bamboo_priv_ip" {
  default = "192.168.33.251"
}
variable "allocation_id_bamboo_ip" {
  default =  "eipalloc-033753e44c42dbe5a"
}