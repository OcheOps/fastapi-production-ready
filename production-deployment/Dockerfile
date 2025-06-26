# ──────────────── Builder Stage ────────────────
FROM python:3.11-slim AS builder

WORKDIR /app

# Install deps
COPY fastapi-service/requirements.txt .
RUN pip install --upgrade pip && pip install --no-cache-dir -r requirements.txt

# Copy source
COPY fastapi-service/ .

# ──────────────── Final Image ────────────────
FROM python:3.11-slim AS final

WORKDIR /app

# Copy installed packages
COPY --from=builder /usr/local /usr/local
COPY --from=builder /app /app

CMD ["python3", "-m", "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
