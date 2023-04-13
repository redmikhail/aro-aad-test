output "k8s_openid_secret" {
  value = kubernetes_secret_v1.openid-client-secret-azuread
  sensitive = true
}
