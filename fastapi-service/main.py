from fastapi import FastAPI
from prometheus_fastapi_instrumentator import Instrumentator
import signal
import sys

app = FastAPI()

@app.on_event("startup")
async def on_startup():
    print("🚀 App is starting...")

@app.on_event("shutdown")
async def on_shutdown():
    print("🛑 App is shutting down gracefully...")

# Optional: intercept SIGTERM (for Docker/K8s)
def handle_sigterm(*args):
    print("SIGTERM received, exiting...")
    sys.exit(0)

signal.signal(signal.SIGTERM, handle_sigterm)

Instrumentator().instrument(app).expose(app)

@app.get("/health")
async def health_check():
    return {"status": "healthy"}

@app.get("/items")
async def get_items():
    return {"items": ["item1", "item2", "item3"]}

@app.post("/items")
async def create_item(item: dict):
    return {"message": "Item created", "item": item}
