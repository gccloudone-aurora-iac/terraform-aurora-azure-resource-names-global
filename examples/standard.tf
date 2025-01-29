module "global_resource_names" {
  source = "../"

  user_defined = "example"
}

output "azure_resource_names" {
  value = module.global_resource_names
}
