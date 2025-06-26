resource "kubernetes_service" "fastapi" {
  metadata {
    name      = "fastapi-service"
    namespace = kubernetes_namespace.fastapi.metadata[0].name
  }

  spec {
    selector = {
      app = "fastapi-app"
    }

    port {
      port        = 80
      target_port = 8000
    }

    type = "ClusterIP"
  }
}
