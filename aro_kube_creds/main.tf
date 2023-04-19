# ================================================================================
# This module does NOT modify/create any Azure resource. It simply uses various
# datasources to fetch kube credentials.
#
# It does create a file at the path specified by aro_cluster_kube_config_path
# variable that contains kube credentials in kube config format
# ================================================================================


#data "azurerm_subscription" "current" {}

data "azurerm_resource_group" "resource_group" {
  name = var.resource_group_name
}

# Use to get all the properties (since we're using response_export_values with "*" in it)
data "azapi_resource" "aro_cluster" {
  type                   = local.resource_type
  name                   = var.cluster_name
  parent_id              = data.azurerm_resource_group.resource_group.id
}

data "azapi_resource_action" "admin-creds" {
  type                   = local.resource_type
  resource_id            = data.azapi_resource.aro_cluster.id
  action                 = "listCredentials"
  response_export_values = ["*"]
}

