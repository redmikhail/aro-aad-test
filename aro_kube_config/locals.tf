locals {
  resource_type                 = "Microsoft.RedHatOpenShift/openShiftClusters@2022-09-04"
  aro_cluster_properties        = jsondecode(data.azapi_resource.aro_cluster_all.output).properties
  aro_cluster_domain            = local.aro_cluster_properties.clusterProfile.domain
  aro_oauth_callback_url        = "https://oauth-openshift.apps.${local.aro_cluster_domain}.${var.region}.aroapp.io/oauth2callback/AAD"
  aro_cluster_admin_kube_config = jsondecode(data.azapi_resource_action.admin-creds.output)
}
