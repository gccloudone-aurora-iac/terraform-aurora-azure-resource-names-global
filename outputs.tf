##################
### Containers ###
##################

// Scope: global
// Length: 3-24
// Valid Characters: Lowercase letters and numbers.
output "storage_account_name" {
  description = "The name of an Azure Storage Account."
  value       = local.resource_names["storage account"]
}

// Scope: global
// Length: 3-24
// Valid Characters: Alphanumerics and hyphens. Start with letter. End with letter or digit. Can't contain consecutive hyphens.
output "key_vault_name" {
  description = "The name of an Azure Key Vault."
  value       = local.resource_names["key vault"]
}

// Scope: global
// Length: 5-50
// Valid Characters: Alphanumerics
output "container_registry_name" {
  description = "The name of an Azure Container Registry."
  value       = local.resource_names["container registry"]
}

################
### Database ###
################

// Scope: global
// Length: 3-63
// Valid Characters: Lowercase letters, hyphens and numbers. Can't start or end with hyphen.
output "postgresql_server_name" {
  description = "The name of an Azure PostgreSQL Server."
  value       = local.resource_names["postgresql server"]
}
