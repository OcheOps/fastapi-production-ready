resource "kubernetes_config_map" "fastapi" {
  metadata {
    name      = "fastapi-config"
    namespace = kubernetes_namespace.fastapi.metadata[0].name
  }

  data = {
    ENV       = "production"
    LOG_LEVEL = "info"
  }
}
