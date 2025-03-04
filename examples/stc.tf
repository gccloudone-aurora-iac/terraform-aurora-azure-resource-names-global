module "global_resource_names_stc" {
  source            = "../"

  user_defined      = "example"
  naming_convention = "stc"
}

output "azure_resource_names_stc_values" {
  value = module.global_resource_names_stc
}
