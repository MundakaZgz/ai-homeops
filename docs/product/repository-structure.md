# Repository structure

Status: agreed top-level structure. This document describes the intended layout; it does not imply that the application directories or deployment files have already been created.

## Organization

The project uses a monorepo. Application code, tests, scripts, and container deployment files belong under `src/`. Project documentation belongs under `doc/`.

GitHub Actions workflow definitions are the exception: they live in `.github/workflows/` and can invoke scripts stored under `src/scripts/`.

```text
.github/
└── workflows/
doc/
├── README.md
├── product/
│   ├── goals-and-success-criteria.md
│   └── mvp-scope-and-non-goals.md
└── architecture/
    └── repository-structure.md
src/
├── backend/
│   ├── domain/
│   ├── application/
│   ├── infrastructure/
│   ├── composition/
│   ├── shared/
│   └── Dockerfile
├── frontend/
│   ├── domain/
│   ├── application/
│   ├── infrastructure/
│   ├── composition/
│   ├── shared/
│   ├── presentation/
│   └── Dockerfile
├── tests/
│   ├── backend/
│   ├── frontend/
│   └── e2e/
├── scripts/
└── compose.yml
```

## Directory responsibilities

| Path | Responsibility |
| --- | --- |
| `.github/workflows/` | GitHub Actions workflow entry points, invoking repository scripts where appropriate |
| `doc/product/` | Product goals, success criteria, MVP scope, and explicit non-goals |
| `doc/architecture/` | Architecture documentation, including the repository layout |
| `src/backend/` | Backend application, organized according to Clean Architecture |
| `src/frontend/` | Frontend application, with architectural layers and a presentation layer |
| `src/tests/backend/` | Backend tests, kept outside the backend application directory |
| `src/tests/frontend/` | Frontend tests, kept outside the frontend application directory |
| `src/tests/e2e/` | End-to-end tests covering the complete system, from the interface through the backend |
| `src/scripts/` | All project scripts, including deployment and auxiliary scripts |
| `src/compose.yml` | Compose definition for deploying the complete system |
| `src/backend/Dockerfile` | Container build definition for the backend |
| `src/frontend/Dockerfile` | Container build definition for the frontend |

## Application layers

| Directory | Responsibility |
| --- | --- |
| `domain/` | Domain concepts and business rules, independent of frameworks and infrastructure |
| `application/` | Application use cases and their coordination of domain behavior |
| `infrastructure/` | Technical implementations and integrations; backend entry points such as HTTP routes, incoming messages, and scheduled processes also belong here |
| `composition/` | Wiring concrete implementations to use cases and configuring dependencies |
| `shared/` | Supporting classes and utilities, such as an implementation of the Result pattern; internal contents remain to be defined |
| `presentation/` | Frontend views, components, and interface logic; this directory is only included in the frontend |

Internal subdirectories are intentionally left undefined. No logging subdirectory or separate shared infrastructure directory is included at this stage.

## Deferred decisions

- The technology stack, including languages and frameworks, remains pending the corresponding ADR.
- Framework-specific directories will be decided after framework selection. Next.js was discussed as an example, not selected; no `app/` directory is committed by this structure.
- The internal organization of each layer, including frontend presentation, will be defined later.
- Build, dependency, and test tool configuration will be determined once the tools are selected. Test tools must be configured to use the agreed directories under `src/tests/`.
- Dockerfiles and Compose contents will be defined during implementation; their locations are agreed here.

This task documents the layout only. Creating the application skeleton is a separate step.
