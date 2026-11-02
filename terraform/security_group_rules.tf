/*------------------
REGLES ENTRANTES (INGRESS)
------------------*/

# EC2 : autoriser SSH depuis mon adresse IP
resource "aws_vpc_security_group_ingress_rule" "ec2_ssh" {
  security_group_id = aws_security_group.ec2.id
  description       = "SSH access"

  ip_protocol = "tcp"
  from_port   = 22
  to_port     = 22
  cidr_ipv4   = "80.215.105.135/32"
}

# EC2 : autoriser PostgREST depuis mon adresse IP
resource "aws_vpc_security_group_ingress_rule" "ec2_postgrest" {
  security_group_id = aws_security_group.ec2.id
  description       = "PostgREST API access"

  ip_protocol = "tcp"
  from_port   = 3000
  to_port     = 3000
  cidr_ipv4   = "0.0.0.0/0"
}

# RDS : autoriser PostgreSQL depuis le groupe de sécurité EC2
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

  ip_protocol = "-1" # -1 signifie tous les protocoles
  cidr_ipv4   = "0.0.0.0/0"
}

# RDS : autoriser toutes les sorties
resource "aws_vpc_security_group_egress_rule" "rds_all" {
  security_group_id = aws_security_group.rds.id

  ip_protocol = "-1" # -1 signifie tous les protocoles
  cidr_ipv4   = "0.0.0.0/0"
}