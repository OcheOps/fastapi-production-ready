#!/bin/bash

APP_URL=${1:-http://localhost:8000/health}

echo "📡 Checking health at: $APP_URL"
curl --silent --fail "$APP_URL" || echo "❌ Health check failed!"
