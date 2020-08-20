output "be_balancer_id" {
  value = aws_instance.be_balancer.id
}
output "be_balancer_pub_ip" {
  value = aws_eip_association.eip_assoc_be.public_ip
}


