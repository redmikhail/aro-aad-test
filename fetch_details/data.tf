
data "azurerm_subscription" "current" {}

data "azuread_client_config" "current" {}

data "azurerm_resource_group" "resource_group" {
  name = var.aro_resource_group_name
}

data "azuread_service_principal" "aro_cluster_sp" {
  application_id = local.aro_cluster_properties.servicePrincipalProfile.clientId
}

# Use to get all the properties (since we're using response_export_values with "*" in it)
data "azapi_resource" "aro_cluster_all" {
  name                   = var.aro_cluster_name
  parent_id              = data.azurerm_resource_group.resource_group.id
  type                   = "Microsoft.RedHatOpenShift/openShiftClusters@2022-04-01"
  response_export_values = ["*"]
}

data "azapi_resource_action" "creds" {
  type                   = "Microsoft.RedHatOpenShift/OpenShiftClusters@2022-04-01"
  resource_id            = data.azapi_resource.aro_cluster_all.id
  action                 = "listCredentials"
  response_export_values = ["*"]
}

data "azapi_resource_action" "admin-creds" {
  type                   = "Microsoft.RedHatOpenShift/OpenShiftClusters@2022-04-01"
  resource_id            = data.azapi_resource.aro_cluster_all.id
  action                 = "listAdminCredentials"
  response_export_values = ["*"]
}
