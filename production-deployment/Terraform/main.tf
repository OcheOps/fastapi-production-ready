provider "kubernetes" {
  config_path = var.kubeconfig_path
}

resource "kubernetes_namespace" "fastapi" {
  metadata {
    name = "fastapi"
  }
}
