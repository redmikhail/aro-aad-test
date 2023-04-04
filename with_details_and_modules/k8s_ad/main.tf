
resource "local_file" "kube-config" {
  filename   = "${path.module}/kubeconfig"
  content    = base64decode(var.kube_config_contents)
}

provider "kubernetes" {
  config_path = local_file.kube-config.filename
}

resource "kubernetes_secret_v1" "openid-client-secret-azuread" {
  metadata {
    name = "openid-client-secret-azuread"
    namespace = "openshift-config"
  }

  data = {
    clientSecret = var.client_secret
  }

  type = "Opaque"
}
