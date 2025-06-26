from fastapi import FastAPI
from prometheus_fastapi_instrumentator import Instrumentator

app = FastAPI()

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
