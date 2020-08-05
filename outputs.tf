output "be_balancer_ip" {
  value = aws_instance.be_balancer.public_ip
}
