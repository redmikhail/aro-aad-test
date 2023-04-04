# ================================================================================
# This module does NOT modify/create any Azure resource. It simply uses various
# datasources to fetch kube credentials.
#
# It does create a file at the path specified by aro_cluster_kube_config_path
# variable that contains kube credentials in kube config format
# ================================================================================

data "azurerm_subscription" "current" {}

data "azurerm_resource_group" "resource_group" {
  name = var.aro_resource_group_name
}

# Use to get all the properties (since we're using response_export_values with "*" in it)
data "azapi_resource" "aro_cluster_all" {
  name                   = var.aro_cluster_name
  parent_id              = data.azurerm_resource_group.resource_group.id
  type                   = "Microsoft.RedHatOpenShift/openShiftClusters@2022-04-01"
  response_export_values = ["*"]
}

data "azapi_resource_action" "admin-creds" {
  type                   = "Microsoft.RedHatOpenShift/OpenShiftClusters@2022-04-01"
  resource_id            = data.azapi_resource.aro_cluster_all.id
  action                 = "listAdminCredentials"
  response_export_values = ["*"]
}

# If kubeconfig needs to be returned as an output instead of an actual file, comment the following local_file resource
resource "local_file" "kube-config" {
  count = var.generate_kube_config ? 1 : 0

  filename = var.aro_cluster_kube_config_path
  content  = base64decode(local.aro_cluster_admin_kube_config.kubeconfig)
}
