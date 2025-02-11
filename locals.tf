resource "random_id" "this" {
  byte_length = 8
}

locals {
  common_convention_base_ssc = "${var.name_attributes_ssc.department_code}${var.name_attributes_ssc.environment}${var.name_attributes_ssc.csp_region}"
  random_number              = substr(random_id.this.dec, 0, 6)
  resource_type_abbreviations_statcan = {
    "storage account"    = "sa"
    "key vault"          = "kv"
    "container registry" = "acr"
    "postgresql server"  = "psql"
  }
  resource_type_abbreviations_ssc = {
    "storage account"    = "stg"
    "key vault"          = "kv"
    "container registry" = "registry"
    "postgresql server"  = "psql"
  }

  resource_names_exception = {
    # For any resources that does not follow the convention <dept code><environment><CSP Region>-<userDefined-string>-suffix
    "storage account" = "${local.common_convention_base_ssc}${var.user_defined}"
  }

  resource_names_statcan = { for resource_type, abbrev in local.resource_type_abbreviations_statcan : resource_type => "${abbrev}${local.random_number}${var.user_defined}" }
  resource_names_ssc = {
    for resource_type, abbrev in local.resource_type_abbreviations_ssc :
    resource_type => (
      contains(keys(local.resource_names_exception), resource_type)
      ? local.resource_names_exception[resource_type]
      : "${local.common_convention_base_ssc}-${var.user_defined}-${abbrev}"
    )
  }
  resource_names = var.government ? local.resource_names_ssc : local.resource_names_statcan
}
