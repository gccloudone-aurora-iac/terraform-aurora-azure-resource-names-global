##############################
#   SSC NAMING CONVENTION    #
##############################
locals {
  common_convention_base_ssc = "${var.name_attributes.department_code}${var.name_attributes.environment}${var.name_attributes.csp_region}"

  resource_type_abbreviations_ssc = {
    "key vault"          = "kv"
    "container registry" = "registry"
    "postgresql server"  = "psql"
    "function app"       = "fn"
    "data lake store"    = ""
    "azure data factory" = "adf"
  }

  # For any resources that don't have a suffix and have their own unique naming pattern.
  resource_names_no_abbrev = {
    "storage account" = "${lower(local.common_convention_base_ssc)}${lower(var.user_defined)}${local.random_number}"
    "data lake store" = "${lower(local.common_convention_base_ssc)}${lower(var.user_defined)}${local.random_number}"
  }

  # The pattern for the child resources of a storage account
  resource_names_sa_children_pattern = "${lower(local.common_convention_base_ssc)}${lower(var.user_defined)}${local.random_number}-${random_string.random.result}"

  resource_names_sa_children = {
    "container" = merge(
      { for sa_name in var.storage_account_names: sa_name => "${sa_name}-${random_string.random.result}" },
      { (var.user_defined) = local.resource_names_sa_children_pattern }
    )
    "queue" = merge(
      { for sa_name in var.storage_account_names: sa_name => "${sa_name}-${random_string.random.result}" },
      { (var.user_defined) = local.resource_names_sa_children_pattern }
    )
    "table" = merge(
      { for sa_name in var.storage_account_names: sa_name => "${sa_name}-${random_string.random.result}" },
      { (var.user_defined) = local.resource_names_sa_children_pattern }
    )
    "file" = merge(
      { for sa_name in var.storage_account_names: sa_name => "${sa_name}-${random_string.random.result}" },
      { (var.user_defined) = local.resource_names_sa_children_pattern }
    )
  }

  resource_names_ssc = merge(
    {
      for resource_type, abbrev in local.resource_type_abbreviations_ssc:
      resource_type => "${local.common_convention_base_ssc}-${var.user_defined}-${abbrev}"
    },
    local.resource_names_no_abbrev,
    local.resource_names_sa_children
  )
}
