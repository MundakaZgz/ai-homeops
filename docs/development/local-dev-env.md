# Local Development Environment

This guide installs and runs the current frontend and backend directly from the repository root (`ai-homeops`).

## Prerequisites

- **Node.js LTS and npm** for the frontend.
- **Python 3.10+** for the backend.
- **Git** to clone the repository.
- **Docker and Docker Compose** are optional; they can run the frontend, backend, and supporting services in containers.

## Install Dependencies

Run these commands from the repository root after cloning:

```bash
git clone <repository-url>
cd ai-homeops

# Frontend: use the package-lock.json in src/frontend
npm ci --prefix src/frontend
```

Create a virtual environment and install the backend requirements. On Windows PowerShell:

```powershell
py -m venv .venv
.\.venv\Scripts\Activate.ps1
python -m pip install -r src/backend/requirements.txt
```

On macOS or Linux:

```bash
python3 -m venv .venv
source .venv/bin/activate
python -m pip install -r src/backend/requirements.txt
```

## Run the Application

Start each service in a separate terminal, with both terminals at the repository root. Activate the virtual environment in the backend terminal before starting the server.

**Backend (FastAPI), Windows PowerShell:**

```powershell
.\.venv\Scripts\Activate.ps1
python -m uvicorn main:app --app-dir src/backend --reload --host 127.0.0.1 --port 8000
```

**Backend (FastAPI), macOS/Linux:**

```bash
source .venv/bin/activate
python -m uvicorn main:app --app-dir src/backend --reload --host 127.0.0.1 --port 8000
```

**Frontend (Next.js), Windows PowerShell:**

```powershell
cd src/frontend
npm run dev
```

On macOS or Linux:

```bash
cd src/frontend && npm run dev
```

The frontend is available at `http://localhost:3000`; the backend root endpoint is at `http://127.0.0.1:8000`.

### Run the Backend in Docker

From the repository root, build and run the backend image:

```bash
bash src/scripts/create_backend_image.sh
docker run --rm -p 8000:8000 ai-homeops-back
```

The backend is available at `http://127.0.0.1:8000`. The image uses Python on Alpine Linux and runs as a non-root user.

### Run the Frontend in Docker

From the repository root, build and run the frontend image:

```bash
bash src/scripts/create_frontend_image.sh
docker run --rm -p 3000:3000 ai-homeops-front
```

The frontend is available at `http://localhost:3000`. The image uses Next.js standalone output and runs as a non-root user.

### Run the Full Stack with Docker Compose

Build both local images from the repository root, then start the Compose stack:

```bash
bash src/scripts/create_backend_image.sh
bash src/scripts/create_frontend_image.sh
docker compose -f src/compose.yml up -d
```

The Compose file uses the generated images `ai-homeops-back` and `ai-homeops-front`, along with the local `db` and `redis` services. The frontend is available at `http://localhost:3000` and the backend at `http://127.0.0.1:8000`. Stop the services with `docker compose -f src/compose.yml down`.

The Docker images are built from the repository root so the root `.dockerignore` rules apply consistently and the Dockerfiles can access the monorepo layout without nested build contexts.

## Environment Variables

The current local frontend and backend do not require environment variables. The `.env.example` files previously referenced here are not present in the repository, so there is nothing to copy or configure for direct local development.

## Tests

Run backend tests from the repository root:

```powershell
.\.venv\Scripts\Activate.ps1
python -m pytest tests/backend -q
```

On macOS or Linux:

```bash
source .venv/bin/activate
python -m pytest tests/backend -q
```

Run the frontend test script from the repository root with:

```bash
cd src/frontend && npm run test -- --run
```

The project includes a minimal backend test for the root endpoint and a minimal frontend render test for the landing page. GitHub Actions also runs both suites automatically on every push and pull request.

## Current Limitations

- Alembic is not listed in the backend requirements, so database migration commands are not available yet.
