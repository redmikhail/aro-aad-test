terraform {
  required_version = ">=1.0"

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">=2.19.0"
    }
#    local = {
#      source = "hashicorp/local"
#    }
  }
}
