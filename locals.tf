resource "random_id" "this" {
  byte_length = 8
}

locals {
  random_number = substr(random_id.this.dec, 0, 6)
  resource_type_abbreviations = {
    "storage account"    = "sa"
    "key vault"          = "kv"
    "container registry" = "acr"
    "postgresql server"  = "psql"
  }

  resource_names = { for resource_type, abbrev in local.resource_type_abbreviations : resource_type => "${abbrev}${local.random_number}${var.user_defined}" }
}
