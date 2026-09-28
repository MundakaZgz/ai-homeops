# ADR 0004: Web-First PWA and Containerized Backend Packaging Strategy

Status: Accepted

## Context

The project needs a deployment and packaging strategy that balances high-quality user experience (especially on mobile) with developer velocity and maintenance simplicity for a solo developer.

## Decision

We will adopt a **Web-First PWA + Containerized Backend** strategy.

### Frontend: Next.js + PWA
- The primary interface will be a responsive web application built with Next.js.
- It will be configured as a Progressive Web App (PWA) to allow users to "install" the app on their mobile devices without going through official app stores.
- This avoids the overhead of maintaining native apps while still providing a native-like experience for the primary use case (mobile access to home maintenance).

### Backend: Python/FastAPI + Docker
- The backend will be built using FastAPI, leveraging Python's rich ecosystem for AI and data processing.
- The backend will be containerized using Docker to ensure consistent behavior across development, staging, and production environments.
- The application will be deployed as a scalable container service (e.g., AWS App Runner, Google Cloud Run, or similar), exposing a RESTful API to the Next.js frontend.

### Rationale

- **Velocity:** PWA allows for rapid updates without waiting for app store approvals.
- **Complexity:** Managing a monorepo with a unified PWA and a containerized backend is significantly simpler for a single maintainer than managing multiple native mobile projects.
- **AI Compatibility:** Python/FastAPI is the de-facto standard for integrating the agentic logic and LLM toolsets required for AI HomeOps.

## Alternatives considered

- **Native Mobile (React Native/Flutter):** Rejected for the MVP. The development and maintenance overhead of native apps is too high for the current scope.
- **Desktop App (Electron):** Rejected as the primary interface. While useful for some users, the core use case is mobile-centric.

## Consequences

- The frontend team must ensure PWA best practices (manifests, service workers, responsive design).
- The backend team must focus on a high-performance, container-ready API.
- CI/CD must be configured to build and push both a web bundle and a Docker image independently.
