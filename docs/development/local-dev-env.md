# Local Development Environment

This document describes how to set up the AI HomeOps project locally for development.

## Prerequisites

To develop locally, you need to have the following installed:

- **Docker & Docker Compose**: Required for running the database, redis, and for containerized development.
- **Python 3.10+**: Required for the backend development.
- **Node.js (LTS)**: Required for the frontend development.
- **pnpm**: Recommended package manager for the frontend.
- **Git**: For version control.

## Getting Started

### 1. Clone and Install Dependencies

```bash
git clone <repository-url>
cd ai-homeops

# Install frontend dependencies
pnpm install

# Install backend dependencies (Poetry recommended)
# If you don't have poetry: pipx install poetry
poetry install
```

### 2. Environment Variables

Copy the example environment files and fill them in with your local configurations:

```bash
cp .env.example .env
cp .env.example.backend .env.backend
cp .env.example.frontend .env.frontend
```

*Note: Ensure you have your API keys (OpenAI, Anthropic, etc.) ready to put in `.env.backend`.*

### 3. Start Infrastructure (Docker)

Use Docker Compose to spin up the core infrastructure (PostgreSQL, Redis, and any other required services):

```bash
docker-compose up -d
```

### 4. Run the Application

You can run the services in parallel using Docker Compose (if configured) or separately:

**Backend (FastAPI):**
```bash
# From the backend directory
uvicorn src.backend.main:app --reload --host 0.0.0.0 --port 8000
```

**Frontend (Next.js):**
```bash
# From the frontend directory
pnpm dev
```

## Development Workflow

### Shared Types
Since we use a monorepo, any changes to shared types or domain models in `src/backend/domain/` should be reflected in the frontend via the shared interfaces.

### Database Migrations
Use **Alembic** for backend migrations:

```bash
# Example commands
poetry run alembic revision --autogenerate -m "initial migration"
poetry run alembic upgrade head
```

### Testing
Run the test suite for each component:

```bash
# Backend tests
poetry run pytest

# Frontend tests
pnpm test
```

## Common Commands

| Task | Command |
| --- | --- |
| Start all services | `docker-compose up -d` |
| Stop all services | `docker-compose down` |
| Run backend migrations | `poetry run alembic upgrade head` |
| Run backend tests | `poetry run pytest` |
| Run frontend tests | `pnpm test` |
| Build Docker images | `docker-compose build` |
