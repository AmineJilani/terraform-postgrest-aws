# Valeurs utiles après déploiement, affichées avec : terraform output

output "ec2_public_ip" {
  description = "Adresse IP publique de l'instance EC2"
  value       = aws_instance.postgrest.public_ip
}

output "rds_endpoint" {
  description = "Adresse de la base RDS (sans le port)"
  value       = aws_db_instance.postgrest.address
}

output "api_url" {
  description = "URL de test de l'API PostgREST"
  value       = "http://${aws_instance.postgrest.public_ip}:3000/concerts?order=id.asc"
}