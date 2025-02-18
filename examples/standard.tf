module "global_resource_names_stc" {
  source = "../"

  user_defined = "example"
}

output "azure_resource_names_stc_values" {
  value = module.global_resource_names_stc
}
