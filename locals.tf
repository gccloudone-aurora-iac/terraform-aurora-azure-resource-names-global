resource "random_id" "this" {
  byte_length = 8
}

resource "random_string" "random" {
  length           = 5
  special          = false
  upper            = false
  numeric          = false
}

locals {
  random_number              = substr(random_id.this.dec, 0, 6)
  common_convention_base_ssc = "${var.name_attributes_ssc.department_code}${var.name_attributes_ssc.environment}${var.name_attributes_ssc.csp_region}"
  resource_type_abbreviations_statcan = {
    "storage account"    = "sa"
    "key vault"          = "kv"
    "container registry" = "acr"
    "postgresql server"  = "psql"
  }
  resource_type_abbreviations_ssc = {
    "key vault"          = "kv"
    "container registry" = "registry"
    "postgresql server"  = "psql"
    "function app"       = "fn"
    "data lake store"    = ""
    "azure data factory" = "adf"
  }

  resource_names_exception = {
    # For any resources that does not follow the convention <dept code><environment><CSP Region>-<userDefined-string>-suffix
    "storage account" = "${lower(local.common_convention_base_ssc)}${lower(var.user_defined)}${local.random_number}"
    "data lake store" = "${lower(local.common_convention_base_ssc)}${lower(var.user_defined)}${local.random_number}"
    "container"       = var.storage_account_name == "" ? "${lower(local.common_convention_base_ssc)}${lower(var.user_defined)}${local.random_number}-${random_string.random.result}" : "${var.storage_account_name}-${random_string.random.result}"
    "queue"           = var.storage_account_name == "" ? "${lower(local.common_convention_base_ssc)}${lower(var.user_defined)}${local.random_number}-${random_string.random.result}" : "${var.storage_account_name}-${random_string.random.result}"
    "table"           = var.storage_account_name == "" ? "${lower(local.common_convention_base_ssc)}${lower(var.user_defined)}${local.random_number}-${random_string.random.result}" : "${var.storage_account_name}-${random_string.random.result}"
    "file"            = var.storage_account_name == "" ? "${lower(local.common_convention_base_ssc)}${lower(var.user_defined)}${local.random_number}-${random_string.random.result}" : "${var.storage_account_name}-${random_string.random.result}"
  }

  resource_names_ssc = merge(
    {
      for resource_type, abbrev in local.resource_type_abbreviations_ssc :
      resource_type => "${local.common_convention_base_ssc}-${var.user_defined}-${abbrev}"
    },
    local.resource_names_exception
  )

  resource_names_statcan = merge(
    {
      for resource_type in keys(local.resource_names_ssc) :
      resource_type => "" if resource_type != lookup(local.resource_type_abbreviations_statcan, resource_type, null)
    },
    { for resource_type, abbrev in local.resource_type_abbreviations_statcan :
      resource_type => "${abbrev}${local.random_number}${var.user_defined}"
    }
  )


  resource_names = var.government ? local.resource_names_ssc : local.resource_names_statcan
}
