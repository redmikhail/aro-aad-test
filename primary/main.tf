module "aro-details" {
  source = "../fetch_details"

  aro_cluster_name        = var.aro_cluster_name
  aro_resource_group_name = var.aro_resource_group_name
  resource_group_location = var.resource_group_location
}

module "ad-config" {
  source = "../k8s_ad"
  providers = {

  }
}