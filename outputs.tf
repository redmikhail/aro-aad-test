
#  ========================================
#  Subscription details
#  ========================================
output "subscription_details-display_name" {
  value = module.aro-details.subscription_details.display_name
}

output "subscription_details-id" {
  value = module.aro-details.subscription_details.id
}

output "subscription_details-subscription_id" {
  value = module.aro-details.subscription_details.subscription_id
}

output "subscription_details-tenant_id" {
  value = module.aro-details.subscription_details.tenant_id
}



#  ========================================
#  ARO cluster details
#  ========================================

# Uncomment to see all the properties of aro_cluster
# # output "aro_cluster_details" {
# #   value = module.aro-details.aro_cluster_details
# # }

output "aro_cluster_details-name" {
  value = module.aro-details.aro_cluster_details.name
}

output "aro_cluster_details-location" {
  value = module.aro-details.aro_cluster_details.location
}



#  ========================================
#  ARO cluster properties details
#  ========================================

# To see all the output properties, uncomment next output
# output "aro_cluster_details-properties-all" {
#   value = module.aro-details.aro_cluster_details-properties
# }


output "aro_cluster_details-apiserver_ip" {
  value = module.aro-details.aro_cluster_details-properties.apiserverProfile.ip
}

output "aro_cluster_details-apiserver_url" {
  value = module.aro-details.aro_cluster_details-properties.apiserverProfile.url
}

output "aro_cluster_details-cluster_resourceGroupId" {
  value = module.aro-details.aro_cluster_details-properties.clusterProfile.resourceGroupId
}

output "aro_cluster_details-cluster_domain" {
  value = module.aro-details.aro_cluster_details-cluster_domain
}

output "aro_cluster_details-console_url" {
  value = module.aro-details.aro_cluster_details-properties.consoleProfile.url
}

output "aro_cluster_details-networkProfile" {
  value = module.aro-details.aro_cluster_details-properties.networkProfile
}

output "aro_cluster_details-servicePrincipalClientId" {
  value = module.aro-details.aro_cluster_details-properties.servicePrincipalProfile.clientId
}

output "aro_cluster_details-ingressProfiles" {
  value = module.aro-details.aro_cluster_details-properties.ingressProfiles
}

output "aro_oauth-callbackURL" {
  value = module.aro-details.aro_oauth-callbackURL
}



#  ========================================
#  ARO creds
#  ========================================

#  For all the properties
# # output "aro_cluster_details-creds_basic" {
# #   value = module.aro-details.aro_cluster_details-creds_basic
# # }

output "aro_cluster_details-creds-id" {
  value = module.aro-details.aro_cluster_details-creds_basic.id
}

output "aro_cluster_details-creds-method" {
  value = module.aro-details.aro_cluster_details-creds_basic.method
}

output "aro_cluster_details-creds-resource_id" {
  value = module.aro-details.aro_cluster_details-creds_basic.resource_id
}

output "aro_cluster_details-creds_json" {
  value = jsondecode(module.aro-details.aro_cluster_details-creds_basic.output)
}




#  ========================================
#  ARO creds - using listAdminCredentials
#  ========================================

#  For all the properties
output "aro_cluster_details-creds_admin" {
  value = module.aro-details.aro_cluster_details-creds_admin
}

# output "aro_cluster_details-creds_admin-id" {
#   value = data.azapi_resource_action.admin-creds.id
# }

# output "aro_cluster_details-creds_admin-method" {
#   value = data.azapi_resource_action.admin-creds.method
# }

# output "aro_cluster_details-creds_admin-resource_id" {
#   value = data.azapi_resource_action.admin-creds.resource_id
# }

# output "aro_cluster_details-creds_admin_json" {
#   value = jsondecode(data.azapi_resource_action.admin-creds.output)
# }

