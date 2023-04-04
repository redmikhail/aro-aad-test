
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
#output "aro_cluster_details" {
#  value = data.azapi_resource.aro_cluster_all
#}

output "aro_cluster_details-name" {
  value = data.azapi_resource.aro_cluster_all.name
}

output "aro_cluster_details-location" {
  value = data.azapi_resource.aro_cluster_all.location
}

output "aro_cluster_details-properties" {
  value = local.aro_cluster_properties
}

#output "azuread_app_password" {
#  value = azuread_application_password.aro_cluster_sp_password
#}
output "aro_cluster_details-sp" {
  value = data.azuread_service_principal.aro_cluster_sp
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

output "aro_cluster_details-kube_config" {
  value = local.aro_cluster_admin_kube_config
}
