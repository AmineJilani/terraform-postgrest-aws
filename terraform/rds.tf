resource "aws_db_instance" "postgrest" {
  identifier     = "postgrest-db"
  engine         = "postgres"
  engine_version = "18.3"
  instance_class = "db.t4g.micro"

  allocated_storage = 20
  storage_type      = "gp2"
  storage_encrypted = true

  username            = "postgres"
  port                = 5432
  publicly_accessible = false
  multi_az            = false

  copy_tags_to_snapshot        = true
  max_allocated_storage        = 1000
  performance_insights_enabled = true

  db_subnet_group_name   = "default-vpc-00a646f36dd46c478"
  vpc_security_group_ids = [aws_security_group.rds.id]

  skip_final_snapshot = true

}