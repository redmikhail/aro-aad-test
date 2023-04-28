
data "azurerm_client_config" "current" {
}

data "azurerm_resource_group" "resource_group" {
  name                = var.resource_group_name
}


#data "azurerm_resource_group" "resource_group" {
#  name = var.resource_group_name
#}
#
## Use to get all the properties (since we're using response_export_values with "*" in it)
#data "azapi_resource" "aro_cluster_all" {
#  type                   = local.resource_type
#  name                   = azapi_resource.aro_cluster.name
#  parent_id              = data.azurerm_resource_group.resource_group.id
#  response_export_values = ["*"]
#}

data "azapi_resource_action" "admin-creds" {
  type                   = local.resource_type
  resource_id            = azapi_resource.aro_cluster.id
  action                 = "listAdminCredentials"
  response_export_values = ["*"]
}

resource "local_file" "kube-config" {
  filename = var.kube_config_path
  content  = base64decode(local.aro_cluster_admin_kube_config.kubeconfig)
}
