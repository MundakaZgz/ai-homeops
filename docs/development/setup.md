# Local Development Setup

This guide helps you set up the development environment for AI HomeOps.

## Prerequisites

- **Node.js** (v18+ recommended)
- **pnpm** (v8+ recommended)
- **Python** (3.9+ recommended)
- **Docker** & **Docker Compose**
- **VSCode**

## Installation

### 1. Install Dependencies

Run the following commands from the root directory:

```bash
# Install workspace dependencies
pnpm install

# Install frontend dependencies
cd src/frontend && pnpm install

# Install backend dependencies
cd ../backend && pip install -r requirements.txt
```

### 2. Start Infrastructure

Use Docker Compose to start the necessary infrastructure (Postgres, Redis, etc.):

```bash
docker compose up -d
```

### 3. Development Commands

| Service | Command | Description |
| --- | --- | --- |
| Frontend | `cd src/frontend && pnpm dev` | Start Next.js dev server |
| Backend | `cd src/backend && uvicorn main:app --reload` | Start FastAPI dev server |
| Tests | `pnpm test` | Run Vitest for frontend |
| Tests | `pytest` | Run Pytest for backend |

## VSCode Setup

We recommend installing the following extensions:
- **ESLint**
- **Prettier**
- **Python** (Microsoft)
- **Pylance**
- **Docker** (Microsoft)
- **Tailwind CSS IntelliSense**
- **Prisma** (if used)
