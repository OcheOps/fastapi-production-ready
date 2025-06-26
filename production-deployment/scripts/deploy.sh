#!/bin/bash
set -e

echo "🔁 Applying all Kubernetes manifests..."
kubectl apply -f ./k8s

echo "✅ Deployment complete."
