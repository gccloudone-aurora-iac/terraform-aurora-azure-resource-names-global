resource "random_id" "this" {
  byte_length = 8
}

resource "random_string" "random" {
  length  = 5
  special = false
  upper   = false
  numeric = false
}

locals {
  random_number = substr(random_id.this.dec, 0, 6)

  resource_names = var.naming_convention == "ssc" ? local.resource_names_ssc : local.resource_names_statcan
}
