
output "aro_cluster_details-cluster_domain" {
  value = local.aro_cluster_domain
}

output "aro_oauth-callbackURL" {
  value = local.aro_oauth_callback_url
}

# If kubeconfig needs to be returned as an output instead of an actual file, uncomment the next output
# AND comment out the kube_config_location output
output "aro_cluster-kube_config" {
  value = var.generate_kube_config ? "kubeConfig generated at: ${var.aro_cluster_kube_config_path}" : local.aro_cluster_admin_kube_config.kubeconfig
}
