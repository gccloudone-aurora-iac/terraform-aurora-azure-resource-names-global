##############################
#   STC NAMING CONVENTION    #
##############################
locals {
  resource_type_abbreviations_stc = {
    "storage account"    = "sa"
    "key vault"          = "kv"
    "container registry" = "acr"
    "postgresql server"  = "psql"
  }

  resource_names_statcan = merge(
    {
      for resource_type in keys(local.resource_names_ssc) :
      resource_type => ""
    },
    { for resource_type, abbrev in local.resource_type_abbreviations_stc :
      resource_type => "${abbrev}${local.random_number}${var.user_defined}"
    }
  )
}
