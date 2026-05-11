from fastapi import FastAPI
from fastapi.staticfiles import StaticFiles
from fastapi.responses import FileResponse
import uvicorn

app = FastAPI()

visit_count = 0

app.mount("/web", StaticFiles(directory="web"), name="web")

@app.get("/")
def root():
    return FileResponse("web/index.html")

@app.get("/ping")
def ping():
    global visit_count
    visit_count += 1
    return {"message": "Hello from Python!", "visits": visit_count}

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)