
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
  value = module.aro-details.aro_cluster_details-name
}

output "aro_cluster_details-location" {
  value = module.aro-details.aro_cluster_details-location
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

output "aro_cluster_details-servicePrincipalApplicationId" {
  value = module.aro-details.aro_cluster_details-sp.application_id
}

output "aro_cluster_details-servicePrincipalApplicationTenantId" {
  value = module.aro-details.aro_cluster_details-sp.application_tenant_id
}

output "aro_cluster_details-servicePrincipalDisplayName" {
  value = module.aro-details.aro_cluster_details-sp.display_name
}

output "aro_cluster_details-servicePrincipalId" {
  value = module.aro-details.aro_cluster_details-sp.id
}

output "aro_cluster_details-servicePrincipalObjectId" {
  value = module.aro-details.aro_cluster_details-sp.object_id
}

output "aro_cluster_details-servicePrincipalType" {
  value = module.aro-details.aro_cluster_details-sp.type
}

# Uncomment to see all the properties related to the cluster
#output "aro_cluster_details-servicePrincipal_properties" {
#  value = module.aro-details.aro_cluster_details-properties
#}

# Uncomment to see all the properties related to the service principal
#output "aro_cluster_details-servicePrincipal" {
#  value = module.aro-details.aro_cluster_details-sp
#}

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

output "aro_cluster_details-creds-type" {
  value = module.aro-details.aro_cluster_details-creds_basic.type
}

# Uncomment if one wants to see kube credentials
#output "aro_cluster_details-creds_json" {
#  value = jsondecode(module.aro-details.aro_cluster_details-creds_basic.output)
#}




#  ========================================
#  ARO creds - using listAdminCredentials
#  ========================================

#  For all the properties
#output "aro_cluster_details-creds_admin" {
#  value = module.aro-details.aro_cluster_details-creds_admin
#}

output "aro_cluster_details-creds_admin-id" {
  value = module.aro-details.aro_cluster_details-creds_admin.id
}

output "aro_cluster_details-creds_admin-method" {
  value = module.aro-details.aro_cluster_details-creds_admin.method
}

output "aro_cluster_details-creds_admin-resource_id" {
  value = module.aro-details.aro_cluster_details-creds_admin.resource_id
}

output "aro_cluster_details-creds_admin-type" {
  value = module.aro-details.aro_cluster_details-creds_admin.type
}

# Uncomment if one wants to see the encoded kube config
#output "aro_cluster_details-creds-kube_config" {
#  value = module.aro-details.aro_cluster_details-kube_config.kubeconfig
#}

# Uncomment if one wants to see the decoded kube config
#output "aro_cluster_details-creds-kube_config-json" {
#  value = base64decode(module.aro-details.aro_cluster_details-kube_config.kubeconfig)
#}


#  ========================================
#  K8s module output
#  ========================================

output "k8s_openid_secret" {
  value = module.ad-config.k8s_openid_secret
  sensitive = true
}

