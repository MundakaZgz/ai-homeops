# Local Development Setup

This guide describes the current local workflow for AI HomeOps, including the direct development setup and the Dockerized stack used for local testing.

## Prerequisites

- **Node.js LTS** and `npm`
- **Python 3.10+** and a virtual environment
- **Git**
- **Docker** and **Docker Compose**
- **VSCode** (recommended)

## 1. Install frontend dependencies

From the repository root:

```bash
npm ci --prefix src/frontend
```

## 2. Prepare the backend environment

Create and activate a virtual environment from the repository root, then install the backend dependencies:

On Windows PowerShell:

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

## 3. Run the application directly

Start each service in a separate terminal from the repository root.

**Backend**

```powershell
.\.venv\Scripts\Activate.ps1
python -m uvicorn main:app --app-dir src/backend --reload --host 127.0.0.1 --port 8000
```

```bash
source .venv/bin/activate
python -m uvicorn main:app --app-dir src/backend --reload --host 127.0.0.1 --port 8000
```

**Frontend**

```bash
cd src/frontend && npm run dev
```

The frontend is available at `http://localhost:3000` and the backend at `http://127.0.0.1:8000`.

## 4. Use the Dockerized stack

The repository builds local images for the backend and frontend from the project root so the Dockerfiles can access the full monorepo context and the centralized root `.dockerignore` rules are applied.

Build the images:

```bash
bash src/scripts/create_backend_image.sh
bash src/scripts/create_frontend_image.sh
```

Then start the full stack with Compose from the repository root:

```bash
docker compose -f src/compose.yml up -d
```

This Compose file runs:

- `ai-homeops-back` for the FastAPI service
- `ai-homeops-front` for the Next.js service
- `postgres:15` for the database
- `redis:7` for the cache service

Stop the stack with:

```bash
docker compose -f src/compose.yml down
```

## 5. Notes for local development

- The current frontend and backend do not require environment variables.
- The Docker images are built with a root project context (`.`) to keep the repository layout and ignore rules consistent across services.
- The local development guide is the reference for the manual setup and the Docker workflow.

## VSCode Setup

We recommend installing the following extensions:

- **ESLint**
- **Prettier**
- **Python** (Microsoft)
- **Pylance**
- **Docker** (Microsoft)
- **Tailwind CSS IntelliSense**
