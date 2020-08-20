output "fe_balancer_id" {
  value = aws_instance.fe_balancer.id
}
output "fe_balancer_pub_ip" {
  value = aws_eip_association.eip_assoc_fe.public_ip
}


