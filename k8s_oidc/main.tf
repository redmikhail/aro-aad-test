#resource "local_file" "kube-config" {
#  count = var.generate_kube_config ? 1 : 0
#
#  filename   = var.kube_config_path
#  content    = base64decode(var.kube_config_contents)
#}

provider "kubernetes" {
#  config_path = var.kube_config_path
  host = var.cluster_url

  client_certificate     = file(var.client_certificate_path)
  client_key             = file(var.client_key_path)
  cluster_ca_certificate = file(var.ca_certificate_path)
}

resource "kubernetes_secret_v1" "openid-client-secret-azuread" {
  metadata {
    name      = "openid-client-secret-azuread"
    namespace = "openshift-config"
  }

  data = {
    clientSecret = var.client_secret
  }

  type = "Opaque"
}

resource "kubernetes_manifest" "oidc" {
  manifest = {
    apiVersion = "config.openshift.io/v1"
    kind       = "OAuth"

    metadata = {
      name = "cluster"
    }

    spec = {
      identityProviders = [
        {
          name          = "AAD"
          mappingMethod = "claim"
          type          = "OpenID"
          openID        = {
            clientID     = var.client_id
            clientSecret = {
              name = "openid-client-secret-azuread"
            }
            extraScopes = [
              "email",
              "profile"
            ]
            extraAuthorizeParameters = {
              include_granted_scopes = "true"
            }
            claims = {
              preferredUsername = [
                "email",
                "upn"
              ]
              name = [
                "name"
              ]
              email = [
                "email"
              ]

            }
            issuer = "https://login.microsoftonline.com/${var.tenant_id}"
          }
        }
      ]
    }
  }
}
