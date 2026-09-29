# ADR 0003: Monorepo Architecture for Development Velocity

Status: Accepted

## Context

The project needs to decide on the organizational structure for the codebase: a monorepo (multiple projects in one repository) or a multi-repository approach (separate repositories for frontend, backend, and other services).

## Decision

The project will use a **monorepo architecture**.

## Rationale

- **Simplicity for Solo Developer:** As the project is currently managed by a single developer, a monorepo reduces overhead significantly, simplifying dependency management, cross-repo refactoring, and the need to manage multiple sets of credentials, CI/CD configurations, and pull requests for a single feature.
- **Shared Code and Types:** Using a monorepo allows for easier sharing of utility scripts and a unified project view between the Next.js frontend and the Python (FastAPI) backend. While the backend is now Python-based, the monorepo structure ensures that both components can be managed, versioned, and deployed as a single cohesive system.
- **Unified CI/CD:** It simplifies the initial setup of GitHub Actions, as all components can be managed within a single repository's workflow definitions.
- **Atomic Commits:** Changes affecting both frontend and backend (e.g., a new "Home Twin" feature) can be committed together, ensuring the repository is always in a consistent state.

## Future Considerations

While a monorepo is the correct choice for the current scale, we acknowledge that as the project grows or if it eventually involves multiple independent teams, we may consider moving to a multi-repository approach to manage team boundaries and independent deployment cycles more effectively.
