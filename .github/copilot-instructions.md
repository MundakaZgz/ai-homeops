# Copilot instructions

## Project shape

AI HomeOps is a monorepo for researching and building an agent-assisted home-maintenance coordination product. The intended workflow spans a maintenance request, gathering context, finding and coordinating providers, human approval where needed, completion evidence, and property-history updates. Traceability and human control are core product requirements; do not assume that external actions or high-impact decisions are autonomous.

Application code is under `src/`: `backend/` is Python/FastAPI and `frontend/` is Next.js/React/TypeScript. The planned organization separates `domain/`, `application/`, `infrastructure/`, `composition/`, and `shared/`; the frontend also has `presentation/`. These directories are currently scaffolding, so follow the layer boundaries as features are added without implying that those layers are already implemented. The current backend entry point is `src/backend/main.py`; the frontend uses the Next.js App Router under `src/frontend/app/`.

Backend tests currently live in the top-level `tests/backend/`; frontend tests are colocated with the app code. Research and evaluation material is kept separately in `experiments/` and `evals/`. Project documentation is in `docs/`, with architecture decisions in `docs/architecture/ADR/`. See [repository structure](../docs/product/repository-structure.md), [MVP scope](../docs/product/mvp-scope-and-specific-no-goals.md), and [local setup](../docs/development/setup.md) for the evolving product and architecture details.

## Build, test, and lint

Run commands from the repository root unless a working directory is stated. Backend dependencies are in `src/backend/requirements.txt`; frontend dependencies are locked in `src/frontend/package-lock.json`.

```bash
# Install dependencies
python -m pip install -r src/backend/requirements.txt
npm ci --prefix src/frontend

# Backend lint and tests
python -m ruff check src/backend tests/backend
python -m pytest tests/backend -q

# Run one backend test
python -m pytest tests/backend/test_main.py::test_root_returns_backend_message -q

# Frontend lint, tests, and production build
npm --prefix src/frontend run lint
npm --prefix src/frontend run test -- --run
npm --prefix src/frontend run build

# Run one frontend test file
npm --prefix src/frontend run test -- --run app/page.test.tsx
```

CI uses Python 3.12 and Node.js 24. The backend can be run from the repository root with `python -m uvicorn main:app --app-dir src/backend --reload --host 127.0.0.1 --port 8000`; run the frontend with `npm --prefix src/frontend run dev`. There is no separate backend build command. The CI source of truth is `.github/workflows/tests.yml`.

## Codebase conventions

- Keep frontend and backend changes in their respective applications; coordinate through explicit HTTP/API contracts rather than relying on a shared runtime or implicit cross-language types. The backend exposes FastAPI routes and OpenAPI; its current local entry point is `main:app` with `src/backend` as the app directory.
- Keep business rules independent of framework and infrastructure as the backend and frontend layer scaffolds are populated. Put technical integrations and inbound entry points in `infrastructure/`, and concrete dependency wiring in `composition/`; consult the repository-structure document when a new module's layer is unclear.
- Python linting uses Ruff with a 100-character configured line length and import sorting (`E`, `F`, `I`, `UP` rules; `E501` is ignored). Keep backend tests under `tests/backend/`; the current tests import the app as `src.backend.main`.
- Frontend TypeScript is strict (`strict` and `noImplicitAny`); the `@/*` alias maps to `src/*`. Use the App Router under `app/`, and keep its focused render tests alongside the page/component they exercise. Vitest is run through the `test` npm script.
- Changes to the user journey should preserve the distinction between a member accepting a proposal and a provider confirming an appointment, and retain evidence needed to explain workflow outcomes. Refer to the MVP scope document for the intended flow.
