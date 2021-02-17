# resource "aws_db_instance" "my_test_mysql" {
#     allocated_storage           = 20
#     storage_type                = "gp2"
#     engine                      = "mysql"
#     engine_version              = "8.0"
#     instance_class              = var.db_instance_type
#     name                        = "myrdstestmysql"
#     username                    = "admin"
#     password                    = "admin123"
#     parameter_group_name        = "default.mysql8.0"
#     db_subnet_group_name        = "rds-private-subnet-group"
#     vpc_security_group_ids      = [var.rds_sg]
#     allow_major_version_upgrade = true
#     auto_minor_version_upgrade  = true
#     backup_retention_period     = 7
#     backup_window               = "22:00-23:00"
#     maintenance_window          = "Sat:00:00-Sat:03:00"
#     multi_az                    = true
#     skip_final_snapshot         = true
# }