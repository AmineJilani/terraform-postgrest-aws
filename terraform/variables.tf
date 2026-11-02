# Variables d'entrée de la configuration.
# Les valeurs sensibles ne sont jamais écrites dans le code :
#   export TF_VAR_db_password='...'

variable "db_password" {
  description = "Mot de passe administrateur de la base RDS"
  type        = string
  sensitive   = true # masqué dans les sorties de plan et apply
}