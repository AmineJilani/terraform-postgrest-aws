# Règles des groupes de sécurité définis dans security_groups.tf

/*------------------
REGLES ENTRANTES (INGRESS)
------------------*/

# EC2 : SSH uniquement depuis l'adresse IP de l'administrateur
resource "aws_vpc_security_group_ingress_rule" "ec2_ssh" {
  security_group_id = aws_security_group.ec2.id
  description       = "SSH access"

  ip_protocol = "tcp"
  from_port   = 22
  to_port     = 22
  cidr_ipv4   = "80.215.105.135/32"
}

# EC2 : API PostgREST accessible depuis tout Internet
resource "aws_vpc_security_group_ingress_rule" "ec2_postgrest" {
  security_group_id = aws_security_group.ec2.id
  description       = "PostgREST API access"

  ip_protocol = "tcp"
  from_port   = 3000
  to_port     = 3000
  cidr_ipv4   = "0.0.0.0/0" # 0.0.0.0/0 = toutes les adresses IPv4
}

# RDS : PostgreSQL accessible uniquement depuis les instances qui portent le groupe de sécurité EC2
resource "aws_vpc_security_group_ingress_rule" "rds_postgres" {
  security_group_id            = aws_security_group.rds.id
  referenced_security_group_id = aws_security_group.ec2.id # Permet d'autoriser un autre groupe de sécurité plutôt qu'une adresse IP.
  description                  = "PostgreSQL access from EC2"

  ip_protocol = "tcp"
  from_port   = 5432
  to_port     = 5432
}

/*------------------
REGLES SORTANTES (EGRESS)
------------------*/

# EC2 : autoriser toutes les sorties
resource "aws_vpc_security_group_egress_rule" "ec2_all" {
  security_group_id = aws_security_group.ec2.id

  ip_protocol = "-1" # -1 = tous les protocoles et tous les ports
  cidr_ipv4   = "0.0.0.0/0"
}

# RDS : toutes les sorties autorisées (règle par défaut créée par AWS).
resource "aws_vpc_security_group_egress_rule" "rds_all" {
  security_group_id = aws_security_group.rds.id

  ip_protocol = "-1"
  cidr_ipv4   = "0.0.0.0/0"
}