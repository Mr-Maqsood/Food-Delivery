data "aws_secretsmanager_secret_version" "rds" {
  secret_id = "myapp/rds/credentials"
}

locals {
  creds = jsondecode(data.aws_secretsmanager_secret_version.rds.secret_string)
}
