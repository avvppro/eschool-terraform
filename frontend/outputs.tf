output "frontend1_id" {
  value = aws_instance.frontend1.id
}
output "frontend2_id" {
  value = aws_instance.frontend2.id
}
output "frontend1_priv_ip" {
  value = var.frontend1_priv_ip
}
output "frontend2_priv_ip" {
  value = var.frontend2_priv_ip
}

