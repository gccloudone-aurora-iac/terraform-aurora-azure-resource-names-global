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

  # Forces STC to have the same structure as SSC's
  resource_names_statcan = merge(
    {
      for resource_type in keys(local.resource_names_ssc) :
      resource_type => ""
    },
    {
        for resource_type in ["container", "queue", "table", "file"] :
        resource_type => {
            stc = ""
        }
    },
    { for resource_type, abbrev in local.resource_type_abbreviations_stc :
      resource_type => "${abbrev}${local.random_number}${var.user_defined}"
    }
  )
}
