output "vpc_id" {
  value = aws_vpc.main.id
}

output "instance_public_ip" {
  value = aws_instance.app_server.public_ip
}

output "alb_dns_name" {
  value = aws_lb.main.dns_name
}

output "application_url" {
  value = "http://${aws_lb.main.dns_name}"
}
