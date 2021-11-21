# resource "aws_db_instance" "lesson7-rds" {
#   allocated_storage    = 10
#   identifier           = "lesson7"
#   storage_type         = "gp2"
#   engine               = "mysql"
#   engine_version       = "5.7"
#   instance_class       = "db.t2.micro"
#   name                 = "sample"
#   username             = "dbadmin"
#   password             = "DBAdmin1qaZ"
#   parameter_group_name = "default.mysql5.7"
#   db_subnet_group_name = aws_db_subnet_group.lesson7-rds-subnet-group.name
# }