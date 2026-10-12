# Default VPC aur uske subnets automatically fetch karo
data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# Security group: sirf VPC ke andar se PostgreSQL access
resource "aws_security_group" "rds_sg" {
  name        = "myapp-rds-sg"
  description = "Allow MySQL from within VPC"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "MySQL from VPC"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.default.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "myapp-rds-sg"
  }
}

# DB subnet group
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "myapp-rds-subnet-group"
  subnet_ids = data.aws_subnets.default.ids

  tags = {
    Name = "myapp-rds-subnet-group"
  }
}

# RDS instance
resource "aws_db_instance" "myapp_rds" {
  identifier        = "myapp-db"
  engine            = "mysql"
  instance_class    = var.db_instance_class
  allocated_storage = 20
  storage_type      = "gp2"

  db_name  = local.creds.dbname
  username = local.creds.username
  password = local.creds.password

  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  publicly_accessible = false
  multi_az            = false
  apply_immediately   = true
  skip_final_snapshot = true   # testing ke liye; production mein false

  tags = {
    Name = "myapp-rds"
  }
}
