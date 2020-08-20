output "db_id" {
  value = aws_instance.database.id
}
output "db_priv_ip" {
  value = var.database_priv_ip
}

