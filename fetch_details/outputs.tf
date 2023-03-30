
#  ========================================
#  Subscription details
#  ========================================
output "subscription_details" {
  value = data.azurerm_subscription.current
}



#  ========================================
#  ARO cluster details
#  ========================================

# Uncomment to see all the properties of aro_cluster
output "aro_cluster_details" {
  value = data.azapi_resource.aro_cluster
}

output "aro_cluster_details-properties" {
  value = local.aro_cluster_properties
}

output "aro_cluster_details-cluster_domain" {
  value = local.aro_cluster_domain
}

output "aro_oauth-callbackURL" {
  value = local.aro_oauth_callback_url
}



#  ========================================
#  ARO creds
#  ========================================

#  For all the properties
output "aro_cluster_details-creds_basic" {
  value = data.azapi_resource_action.creds
}



#  ========================================
#  ARO creds - using listAdminCredentials
#  ========================================

#  For all the properties
output "aro_cluster_details-creds_admin" {
  value = data.azapi_resource_action.admin-creds
}
