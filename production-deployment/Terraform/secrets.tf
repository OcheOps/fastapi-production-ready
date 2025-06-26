resource "kubernetes_secret" "fastapi" {
  metadata {
    name      = "fastapi-secrets"
    namespace = kubernetes_namespace.fastapi.metadata[0].name
  }

  data = {
    DB_PASSWORD = base64encode("secure_password")
  }

  type = "Opaque"
}
