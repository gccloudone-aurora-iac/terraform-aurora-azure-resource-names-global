module "azure_resource_names_ssc" {
  source = "../"

  naming_convention = "ssc"
  user_defined      = "example"
  name_attributes = {
    department_code = "Sc"
    environment     = "P"
    csp_region      = "c"
  }
  storage_account_names = ["scdcproject67"]
}

output "azure_resource_prefixes_ssc_values" {
  value = module.azure_resource_names_ssc
}

output "sa_container_name" {
    value = module.azure_resource_names_ssc.container_name["scdcproject67"]
}
