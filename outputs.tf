output "be_balancer_ip" {
  value = aws_eip_association.eip_assoc_be.public_ip
}
output "fe_balancer_ip" {
  value = aws_eip_association.eip_assoc_fe.public_ip
}
output "bamboo_ip" {
  value = aws_eip_association.eip_assoc_bamboo.public_ip
}