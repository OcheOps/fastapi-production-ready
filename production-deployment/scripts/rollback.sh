#!/bin/bash

DEPLOYMENT_NAME="fastapi-app"
NAMESPACE="default"

echo "🔄 Rolling back deployment $DEPLOYMENT_NAME..."
kubectl rollout undo deployment "$DEPLOYMENT_NAME" -n "$NAMESPACE"
