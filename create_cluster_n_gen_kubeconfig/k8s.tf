#
#resource "local_file" "kube-config" {
#  filename = var.kube_config_path
#  content  = base64decode(local.aro_cluster_admin_kube_config.kubeconfig)
#}
#
#provider "kubernetes" {
#    config_path = var.kube_config_path
#}
#
#resource "kubernetes_secret_v1" "openid-client-secret-azuread" {
#  metadata {
#    name      = "openid-client-secret-azuread"
#    namespace = "openshift-config"
#  }
#
#  data = {
#    clientSecret = var.aro_cluster_aad_sp_client_secret
#  }
#
#  type = "Opaque"
#}
#
#resource "kubernetes_manifest" "oidc" {
#  manifest = {
#    apiVersion = "config.openshift.io/v1"
#    kind       = "OAuth"
#
#    metadata = {
#      name = "cluster"
#    }
#
#    spec = {
#      identityProviders = [
#        {
#          name          = "AAD"
#          mappingMethod = "claim"
#          type          = "OpenID"
#          openID        = {
#            clientID     = var.aro_cluster_aad_sp_client_id
#            clientSecret = {
#              name = "openid-client-secret-azuread"
#            }
#            extraScopes = [
#              "email",
#              "profile"
#            ]
#            extraAuthorizeParameters = {
#              include_granted_scopes = "true"
#            }
#            claims = {
#              preferredUsername = [
#                "email",
#                "upn"
#              ]
#              name = [
#                "name"
#              ]
#              email = [
#                "email"
#              ]
#
#            }
#            issuer = "https://login.microsoftonline.com/${var.tenant_id}"
#          }
#        }
#      ]
#    }
#  }
#}
