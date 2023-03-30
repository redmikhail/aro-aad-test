data "azurerm_subscription" "current" {
}

data "azurerm_resource_group" "resource_group" {
  name = var.aro_resource_group_name
}

data "azapi_resource" "aro_cluster" {
  # resource_group_name = var.aro_resource_group_name
  name      = var.aro_cluster_name
  parent_id = data.azurerm_resource_group.resource_group.id
  type      = "Microsoft.RedHatOpenShift/openShiftClusters@2022-04-01"
}

data "azapi_resource" "aro_cluster_all" {
  name      = var.aro_cluster_name
  parent_id = data.azurerm_resource_group.resource_group.id
  type      = "Microsoft.RedHatOpenShift/openShiftClusters@2022-04-01"
  response_export_values = ["*"]
}

data "azapi_resource_action" "creds" {
  type                   = "Microsoft.RedHatOpenShift/OpenShiftClusters@2022-04-01"
  resource_id            =  data.azapi_resource.aro_cluster.id
  action                 = "listCredentials"
  response_export_values = ["*"]
}

data "azapi_resource_action" "admin-creds" {
  type                   = "Microsoft.RedHatOpenShift/OpenShiftClusters@2022-04-01"
  resource_id            =  data.azapi_resource.aro_cluster.id
  action                 = "listAdminCredentials"
  response_export_values = ["*"]
}
