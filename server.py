#!/usr/bin/env python3
import uvicorn
from typing import Optional
from fastapi import FastAPI
from fastapi.responses import PlainTextResponse
from yaml import dump

app = FastAPI()


@app.get("/", response_class=PlainTextResponse)
def read_root():
    return dump({"foo": {"bar": {"baz": 3}}})


@app.get("/items/{item_id}")
def read_item(item_id: int, q: Optional[str] = None):
    return {"item_id": item_id, "q": q}

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)
