# Branching strategy

Status: agreed. This document defines the repository policy; it does not imply that GitHub rules or CI checks have already been configured.

## Workflow

The project follows GitHub Flow for a single maintainer:

1. Create a short-lived branch from the latest `main` for a focused change.
2. Implement the change and perform the relevant local checks.
3. Open a pull request targeting `main`, describing the change and referencing related issues or user stories.
4. Review the diff and validation results. Once required CI checks are configured, they must pass before merging.
5. Merge using **squash merge**, producing one commit on `main` for the pull request.
6. Delete the merged branch.

`main` is the stable integration branch. There is no `develop` branch. All changes, including documentation and small fixes, must go through a pull request; direct commits to `main` are not allowed.

The maintainer may merge their own pull requests. Approval from another person is not required.

## Branch names

Use English names with lowercase words separated by hyphens:

```text
<type>/<issue-number>-<short-description>
```

Include the number of the primary GitHub issue or user story when one exists. If no issue is associated with the change, omit the number:

```text
<type>/<short-description>
```

| Prefix | Purpose | Example |
| --- | --- | --- |
| `feat/` | New functionality | `feat/42-assisted-task-creation` |
| `fix/` | Bug fixes | `fix/57-prevent-duplicate-appointments` |
| `docs/` | Documentation | `docs/branching-strategy` |
| `chore/` | Maintenance and configuration | `chore/63-configure-ci` |
| `refactor/` | Code restructuring without changing behavior | `refactor/71-extract-availability-policy` |
| `test/` | Test changes | `test/84-cover-cancellation-flow` |

When a change relates to multiple issues, use the primary issue number in the branch name and reference the others in the pull request body. Example numbers in this document are illustrative.

## Pull request titles and squash commits

Pull request titles follow Conventional Commits:

```text
<type>(<optional-scope>): <short-description>
```

Examples:

```text
feat(tasks): add assisted task creation
fix(appointments): prevent duplicate confirmations
docs: define branching strategy
```

Use the same types as the branch prefixes. Write titles in English. For a breaking change, add `!` before the colon and explain the impact in the pull request body.

The pull request title becomes the squash commit subject. Verify it before merging so that `main` has one clearly named commit per pull request. This policy applies to pull request titles and squash commits; it does not require every intermediate branch commit to follow Conventional Commits.

## Issues and user stories

Reference GitHub issues and user stories represented as issues in the pull request body. A pull request may reference several items.

- Use `Closes #<number>` when the pull request completes that issue and it should be closed on integration into the default branch.
- Use `Refs #<number>` for related work or partial implementation that should leave the issue open.
- Do not close a larger user story when the pull request only completes one of its tasks.

Example:

```markdown
Title: feat(tasks): add assisted task creation

## Change

Allow family members to prepare a task through guided questions.

## Validation

Describe the checks performed and their results.

## Related work

Refs #42
Closes #45
Closes #46
```

In this example, `#42` is a broader user story that remains open, while `#45` and `#46` are completed issues. `Refs` is the project's convention for a non-closing reference.

## Repository settings to apply

The intended GitHub configuration is:

- Use `main` as the default branch.
- Require pull requests for changes to `main` and prevent direct pushes.
- Do not require approval from another reviewer.
- Require the relevant CI status checks once those checks exist and are configured.
- Use squash merge as the only enabled pull request merge method.
- Use the pull request title as the squash commit subject.
- Delete branches after merge, automatically where configured or manually otherwise.

The exact required checks will be defined when CI is introduced. No specific CI tools, technology stack, or deployment workflow are selected by this document.
