
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

output "aro_cluster_details-sp" {
  value = data.azuread_service_principal.aro_cluster_sp
}

output "aro_cluster_details-cluster_domain" {
  value = local.aro_cluster_domain
}

output "aro_oauth-callbackURL" {
  value = local.aro_oauth_callback_url
}

output "aro_cluster_details-creds_basic" {
  value = data.azapi_resource_action.creds
}

output "aro_cluster-apiServer-url" {
  value = local.aro_cluster_properties.apiserverProfile.url
}