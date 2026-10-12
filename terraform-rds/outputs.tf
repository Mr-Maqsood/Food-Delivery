output "rds_endpoint" {
  value = aws_db_instance.myapp_rds.endpoint
}

output "rds_port" {
  value = aws_db_instance.myapp_rds.port
}

output "rds_db_name" {
  value     = aws_db_instance.myapp_rds.db_name
  sensitive = true
}

output "rds_address" {
  value = aws_db_instance.myapp_rds.address
}

output "secret_arn" {
  value = data.aws_secretsmanager_secret_version.rds.arn
}
