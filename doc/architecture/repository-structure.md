# Repository structure

Application code, tests, deployment files, and scripts belong under `src/`.
Documentation belongs under `doc/`.
GitHub Actions workflow definitions belong under `.github/workflows/`.

Backend layers: domain, application, infrastructure, composition, shared.
Frontend layers: domain, application, infrastructure, composition, shared,
presentation.

Tests belong under `src/tests/backend/`, `src/tests/frontend/`, and
`src/tests/e2e/`. All project scripts belong under `src/scripts/`.

Each application has its own Dockerfile. The shared Compose definition
belongs at `src/compose.yml`.

The technology stack and framework-specific directories remain pending ADR.
