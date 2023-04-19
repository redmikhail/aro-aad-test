locals {
  resource_type                = "Microsoft.RedHatOpenShift/openShiftClusters@2022-09-04"
  aro_cluster_admin_kube_creds = jsondecode(data.azapi_resource_action.admin-creds.output)
}
