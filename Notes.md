\*\*FastAPI Kubernetes Debug Log – Local Cluster (Minikube)

**Context:**
Deployment of a FastAPI application using Kubernetes with production-ready practices (multi-stage Docker builds, probes, HPA, secrets, network policies, monitoring).

---

**Issues Encountered and Fixes**

1. **Service Port Mismatch (kubectl port-forward error)**

   * **Error:** `Service fastapi-service does not have a service port 8000`
   * **Root Cause:** The Kubernetes `Service` exposed port 80, but I tried to forward 8000.
   * **Fix:** Used `kubectl port-forward svc/fastapi-service 8000:80` to map local 8000 to cluster's 80.

2. **Helm Install Timeout for Prometheus Stack**

   * **Error:** `INSTALLATION FAILED: failed pre-install: timed out waiting for the condition`
   * **Root Cause:** Cluster was under-resourced or CRDs delayed.
   * **Fixes:**

     * Extended timeout: `--timeout 10m`
     * Cleaned up stuck release: `helm uninstall monitoring -n monitoring`
     * Restarted fresh install after ensuring no dangling CRDs.

3. **Readiness Probe Failing**

   * **Error:** `Readiness probe failed: dial tcp ... connection refused`
   * **Root Cause:** FastAPI app wasn’t binding to 0.0.0.0 or wasn’t ready before probe started.
   * **Fixes:**

     * Ensured app used `uvicorn main:app --host 0.0.0.0 --port 8000`
     * Confirmed `/health` route existed and worked
     * Logs and port scans validated correct port binding

4. **Pod Rejections from NetworkPolicy**

   * **Symptom:** Prometheus could not scrape metrics
   * **Root Cause:** `deny-all` network policy blocked traffic
   * **Fix:** Created `networkpolicy-allow-prometheus.yaml` to allow ingress from Prometheus pods

5. **SecurityContext Not Applied Initially**

   * **Gap:** Deployment ran as default root user
   * **Fix:** Added `runAsUser`, `runAsNonRoot`, `readOnlyRootFilesystem`, and capability drops in `Deployment.yaml`

6. **Helm Release Conflict**

   * **Error:** `cannot re-use a name that is still in use`
   * **Root Cause:** Failed Helm install left release metadata
   * **Fix:**

     * Deleted namespace
     * Uninstalled release: `helm uninstall monitoring -n monitoring`
     * Verified with `helm ls`

7. **Command Confusion: `kubectl get pods w`**

   * **Error:** `Error from server (NotFound): pods "w" not found`
   * **Root Cause:** Mistyped `-w` flag
   * **Fix:** Used correct watch command: `kubectl get pods -w`

---

**Current Status Before EKS Migration**

* Deployment: Secure, running as non-root, probes functional
* Monitoring: Prometheus + Grafana installed via Helm
* HPA, NetworkPolicies, and Secrets all applied
* Cluster: Minikube (shutdown initiated)

Ready to migrate setup to AWS EKS.
