# output "rds_endpoint" {
#   description = "The address of the RDS instance"
#   value       = aws_db_instance.lesson12-rds.endpoint
# }

output "ec2_endpoint" {
  description = "The address of the EC2 instance"
  value       = aws_instance.lesson12-ec2.public_ip
}

output "apache_endpoint" {
  description = "The address of the Apache instance"
  value = aws_instance.lesson12-apache.public_ip
}