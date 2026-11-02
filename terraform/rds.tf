# rds.tf : Base de données PostgreSQL managée (Amazon RDS) utilisée par PostgREST.


/*DB subnet group créé par la console RDS, importé dans Terraform.
 Il indique à RDS dans quels subnets la base peut être placée.*/
resource "aws_db_subnet_group" "default" {
  name        = "default-vpc-00a646f36dd46c478"
  description = "Created from the RDS Management Console"
  subnet_ids  = data.aws_subnets.default.ids
}

resource "aws_db_instance" "postgrest" {
  identifier     = "postgrest-db" # nom de l'instance dans AWS
  engine         = "postgres"
  engine_version = "18.3"
  instance_class = "db.t4g.micro"

  allocated_storage     = 20 # taille initiale en Gio
  max_allocated_storage = 1000
  storage_type          = "gp2"
  storage_encrypted     = true

  #Identifiants administrateur
  username = "postgres"
  password = var.db_password # fourni via TF_VAR_db_password (variable)

  port                   = 5432
  publicly_accessible    = false # pas d'IP publique : base joignable uniquement depuis le VPC
  multi_az               = false # une seule zone de disponibilité (Single-AZ)
  db_subnet_group_name   = aws_db_subnet_group.default.name
  vpc_security_group_ids = [aws_security_group.rds.id] # n'accepte que l'EC2 sur 5432

  copy_tags_to_snapshot        = true
  performance_insights_enabled = true

  skip_final_snapshot = true

  lifecycle {
    /* Le mot de passe n'est pas renvoyé par AWS après un import :
    on évite que Terraform tente de le réécrire sur la base existante.*/
    ignore_changes = [password]
  }

}