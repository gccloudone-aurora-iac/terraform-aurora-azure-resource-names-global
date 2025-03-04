module "azure_resource_prefixes_ssc" {
  source = "../"

  naming_convention = "ssc"
  user_defined      = "example"
  name_attributes = {
    department_code = "Sc"
    environment     = "P"
    csp_region      = "c"
  }
}

output "azure_resource_prefixes_ssc_values" {
  value = module.azure_resource_prefixes_ssc
}
