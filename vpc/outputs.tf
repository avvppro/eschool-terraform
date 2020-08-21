output "region" {
  value = var.region
}
output "ami" {
  value = data.aws_ami.latest_amazon_linux.id
}
output "stage" {
  value = var.stage
}
output "vpc0_id" {
  value = aws_vpc.vpc0.id
}
output "zone_name" {
  value = data.aws_availability_zones.available.names[0]
}
output "internal_subnet_id" {
  value = aws_subnet.internal.id
}
output "common_tags" {
  value = var.common_tags
}
