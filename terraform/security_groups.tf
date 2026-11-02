#Groupes de sécurité (pare-feu virtuels) de l'EC2 et de la base RDS.
#Ressources créées depuis la console AWS puis importées avec terraform import.

# Groupe de sécurité de l'instance EC2
resource "aws_security_group" "ec2" {
  name        = "postgrest-ec2-sg"
  description = "launch-wizard-1 created 2026-11-01T09:17:12.801Z"
  vpc_id      = data.aws_vpc.default.id
}

# Groupe de sécurité de la base RDS (PostgreSQL)
resource "aws_security_group" "rds" {
  name        = "postgrest-rds-sg"
  description = "Created by RDS management console"
  vpc_id      = data.aws_vpc.default.id
}


