
resource "aws_security_group" "ec2" {
  name        = "postgrest-ec2-sg"
  description = "launch-wizard-1 created 2026-11-01T09:17:12.801Z"
  vpc_id      = "vpc-00a646f36dd46c478"
}

resource "aws_security_group" "rds" {
  name        = "postgrest-rds-sg"
  description = "Created by RDS management console"
  vpc_id      = "vpc-00a646f36dd46c478"
}

