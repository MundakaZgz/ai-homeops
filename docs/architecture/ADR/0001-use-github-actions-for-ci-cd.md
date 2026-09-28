# ADR 0001: Use GitHub Actions for CI/CD

## Status

Accepted

## Context

The project needs continuous integration for pull requests targeting `main` and, later, continuous delivery of the backend and frontend applications as Docker containers. The repository is hosted on GitHub and maintained by a single person.

The [branching strategy](../../development/branching-strategy.md) requires that all changes to `main` go through a pull request and that required CI checks pass before merging, but it did not select a CI/CD tool.

## Decision

Use **GitHub Actions** as the CI/CD platform.

- Workflow definitions live in `.github/workflows/`.
- Workflows invoke repository scripts under `src/scripts/` where appropriate, so checks can also run locally.
- Required status checks on `main` are defined in the [CI/CD strategy](../../development/ci-cd.md).

## Alternatives considered

- **GitLab CI / CircleCI**: external services that add account, credential, and billing management without a compensating benefit while the repository lives on GitHub.
- **Jenkins (self-hosted)**: infrastructure to provision and maintain, disproportionate for a single-maintainer project.

## Consequences

- CI/CD configuration is versioned in the repository and reviewed through pull requests like any other change.
- No external CI service or self-hosted runner infrastructure is required at this stage.
- The project is coupled to GitHub for automation; migrating away would require rewriting the workflows, though the invoked scripts under `src/scripts/` would remain reusable.
- The technology stack and deployment targets are still open decisions; this ADR only selects the CI/CD platform.
