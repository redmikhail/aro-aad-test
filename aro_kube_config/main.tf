# ================================================================================
# This module does NOT modify/create any Azure resource. It simply uses various
# datasources to fetch kube credentials.
#
# It does create a file at the path specified by aro_cluster_kube_config_path
# variable that contains kube credentials in kube config format
# ================================================================================

data "azurerm_subscription" "current" {}

data "azurerm_resource_group" "resource_group" {
  name = var.resource_group_name
}

# Use to get all the properties (since we're using response_export_values with "*" in it)
data "azapi_resource" "aro_cluster_all" {
  type                   = local.resource_type
  name                   = var.aro_cluster_name
  parent_id              = data.azurerm_resource_group.resource_group.id
  response_export_values = ["*"]
}

data "azapi_resource_action" "admin-creds" {
  type                   = local.resource_type
  resource_id            = data.azapi_resource.aro_cluster_all.id
  action                 = "listAdminCredentials"
  response_export_values = ["*"]
}

resource "local_file" "kube-config" {
  count = var.generate_kube_config ? 1 : 0

  filename = var.aro_cluster_kube_config_path
  content  = base64decode(local.aro_cluster_admin_kube_config.kubeconfig)
}
