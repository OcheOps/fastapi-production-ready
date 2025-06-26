# 🚀 Production Deployment Runbook for FastAPI on EKS

## Overview
This guide covers deploying the FastAPI service to EKS, including config, logs, and rollback steps.

---

## 📦 Prerequisites

- AWS CLI + credentials
- `kubectl` access to the EKS cluster
- Docker installed
- Terraform installed (optional)

---

## 🚀 Deploy Service

```bash
cd production-deployment/scripts
./deploy.sh

♻️ Rollback

cd production-deployment/scripts
./rollback.sh


kubectl rollout undo deployment fastapi-app


