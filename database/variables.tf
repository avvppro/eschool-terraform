variable "instance_type" {
  default = "t2.micro"
 }
variable "allow_ports_database" {
  default =  ["22", "3306"]
}
variable "database_priv_ip" {
  default = "192.168.33.11"
}