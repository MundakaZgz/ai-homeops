# CI/CD strategy

Status: agreed. CI/CD is implemented with GitHub Actions. Workflows will be introduced incrementally as the technology stack and application code are defined; the checks described here become required as the corresponding workflows exist.

## Decision

The project uses **GitHub Actions** for continuous integration and continuous delivery.

Rationale:

- The repository is hosted on GitHub, so GitHub Actions requires no additional service, credentials management, or billing setup.
- Workflows are defined as code in the repository, versioned and reviewed through the same pull request process as any other change.
- The marketplace ecosystem covers the expected needs (language toolchains, Docker builds, caching) without custom infrastructure.
- For a single maintainer, the free tier and GitHub-hosted runners are sufficient.

Alternatives such as GitLab CI, CircleCI, or Jenkins were not selected because they add an external service or self-hosted infrastructure without a compensating benefit at this stage.

## Workflow location

Workflow definitions live in `.github/workflows/`. Following the [repository structure](../product/repository-structure.md), workflows act as entry points and invoke scripts stored under `src/scripts/` where appropriate, so that the same checks can be run locally and in CI.

## Continuous integration

CI runs on every pull request targeting `main` and on every push to `main`.

The pipeline is organized in stages that are added as the corresponding code and tooling exist:

| Stage | Purpose | Introduced when |
| --- | --- | --- |
| Lint and format checks | Enforce code style and static analysis | Backend or frontend tooling is selected |
| Unit tests | Run backend and frontend tests from `src/tests/` | First application code exists |
| Build | Compile the applications and build the Docker images defined by `src/backend/Dockerfile` and `src/frontend/Dockerfile` | Dockerfiles are implemented |
| End-to-end tests | Run the scenarios in `src/tests/e2e/` against the composed system | The system can be deployed locally with `src/compose.yml` |

Each stage fails the workflow on error. Pull requests cannot be merged while a required check is failing, per the [branching strategy](branching-strategy.md).

## Continuous delivery

Deployment targets and environments are not defined yet. When they are:

- Merges to `main` trigger the delivery workflow.
- Docker images are built and tagged from the squash commit on `main`.
- Deployment is performed through scripts in `src/scripts/` invoked from the workflow, keeping the deploy logic runnable outside GitHub Actions.

Until then, CI/CD scope covers integration checks only, and this document will be updated when the delivery workflow is introduced.

## Required status checks

The following become required status checks on `main` as the workflows are created:

- Lint and format checks.
- Unit tests.
- Build (applications and Docker images).

End-to-end tests become a required check once they are stable enough to run on every pull request; until then they may run only on `main` or on demand.

## Workflow authoring conventions

- One workflow per concern (for example, `ci.yml` for pull request checks), rather than a single monolithic workflow.
- Pin action versions by commit SHA or by major version tag, and keep them updated deliberately.
- Use GitHub-hosted runners unless a workflow requires otherwise.
- Do not store secrets in workflow files; use GitHub Actions secrets and variables.
