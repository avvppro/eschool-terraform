output "bamboo_id" {
  value = aws_instance.bamboo.id
}
output "bamboo_public_ip" {
  value = aws_eip_association.eip_assoc_bamboo.public_ip
}


