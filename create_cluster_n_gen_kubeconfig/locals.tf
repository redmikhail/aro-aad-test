
locals {
  resource_group_id = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/aro-${var.domain}-${var.location}"

  resource_type                 = "Microsoft.RedHatOpenShift/openShiftClusters@2022-09-04"
#  aro_cluster_properties        = jsondecode(data.azapi_resource.aro_cluster_all.output).properties
  aro_cluster_admin_kube_config = jsondecode(data.azapi_resource_action.admin-creds.output)
}
