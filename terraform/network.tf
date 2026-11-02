# Lecture du réseau par défaut de la région (VPC et subnets).
# Ce sont des data sources : Terraform lit ces ressources existantes
# sans les créer, les modifier ni les supprimer.
# =============================================================================

# VPC par défaut de la région
data "aws_vpc" "default" {
  default = true
}

# Subnets du VPC par défaut
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# Subnet par défaut de la zone de disponibilité utilisée par l'EC2
data "aws_subnet" "ec2" {
  vpc_id            = data.aws_vpc.default.id
  availability_zone = "eu-north-1a"
  default_for_az    = true
}