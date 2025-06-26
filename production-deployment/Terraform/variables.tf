variable "kubeconfig_path" {
  description = "Path to the kubeconfig file"
  type        = string
  default     = "~/.kube/config"
}

variable "image" {
  description = "Docker image to deploy"
  type        = string
}
