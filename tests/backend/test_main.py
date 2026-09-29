from fastapi.testclient import TestClient

from src.backend.main import app

client = TestClient(app)


def test_root_returns_backend_message() -> None:
    response = client.get("/")

    assert response.status_code == 200
    assert response.json() == {"message": "AI HomeOps Backend is running"}
