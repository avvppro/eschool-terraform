output "backend1_id" {
  value = aws_instance.backend1.id
}
output "backend2_id" {
  value = aws_instance.backend2.id
}
output "backend1_priv_ip" {
  value = var.backend1_priv_ip
}
output "backend2_priv_ip" {
  value = var.backend2_priv_ip
}

