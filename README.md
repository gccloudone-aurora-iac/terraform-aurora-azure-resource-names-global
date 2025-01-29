# terraform-aurora-azure-resource-prefixes-global

This module produces resource names using the global naming convention for global Azure resources.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0, < 2.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_random"></a> [random](#provider\_random) | n/a |



## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_user_defined"></a> [user\_defined](#input\_user\_defined) | A user-defined field that describes the Azure resource. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_container_registry_name"></a> [container\_registry\_name](#output\_container\_registry\_name) | The name of an Azure Container Registry. |
| <a name="output_key_vault_name"></a> [key\_vault\_name](#output\_key\_vault\_name) | The name of an Azure Key Vault. |
| <a name="output_postgresql_server_name"></a> [postgresql\_server\_name](#output\_postgresql\_server\_name) | The name of an Azure PostgreSQL Server. |
| <a name="output_storage_account_name"></a> [storage\_account\_name](#output\_storage\_account\_name) | The name of an Azure Storage Account. |
<!-- END_TF_DOCS -->

## History

| Date       | Release | Change                                          |
| ---------- | ------- | ----------------------------------------------- |
| 2025-01-25 | v1.0.0  | Initial commit                                  |
