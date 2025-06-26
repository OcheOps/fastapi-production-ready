resource "kubernetes_deployment" "fastapi" {
  metadata {
    name      = "fastapi-app"
    namespace = kubernetes_namespace.fastapi.metadata[0].name
    labels = {
      app = "fastapi-app"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "fastapi-app"
      }
    }

    template {
      metadata {
        labels = {
          app = "fastapi-app"
        }
      }

      spec {
        container {
          name  = "fastapi"
          image = var.image

          port {
            container_port = 8000
          }

          env_from {
            config_map_ref {
              name = kubernetes_config_map.fastapi.metadata[0].name
            }
          }

          env_from {
            secret_ref {
              name = kubernetes_secret.fastapi.metadata[0].name
            }
          }

          resources {
            limits = {
              cpu    = "500m"
              memory = "256Mi"
            }
            requests = {
              cpu    = "100m"
              memory = "128Mi"
            }
          }
        }

        service_account_name = kubernetes_service_account.fastapi.metadata[0].name
      }
    }
  }
}
