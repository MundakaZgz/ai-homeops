# AI HomeOps

> An agentic AI platform for coordinating remote property maintenance.

AI HomeOps explores how autonomous AI agents can coordinate real-world maintenance and operations for properties whose owners are not physically present.

The initial use case focuses on **second homes in Spain**, where maintenance often requires coordinating owners, trusted contacts, local caretakers, and service professionals across long-running, asynchronous workflows.

This repository contains the research, experiments, architecture, evaluations, and implementation developed as part of a Master's Final Project (TFM) on AI-powered software development.

---

## The Problem

Owning a second home creates a particular operational problem:

**things often need to happen when the owner is somewhere else.**

A typical maintenance issue may look simple:

> "There is some humidity under the kitchen sink. I won't be back for two months. Get it fixed."

In practice, resolving it may require:

1. Understanding the problem.
2. Gathering additional information.
3. Finding an appropriate professional.
4. Contacting one or more providers.
5. Requesting and comparing quotes.
6. Coordinating access to the property.
7. Getting approval from the owner.
8. Scheduling the intervention.
9. Handling cancellations or unexpected changes.
10. Verifying that the work was completed.
11. Collecting invoices, photos, and warranties.
12. Updating the property's maintenance history.

Today, much of this coordination happens manually through phone calls, WhatsApp messages, emails, calendars, notes, and spreadsheets.

AI HomeOps investigates how much of this workflow can be delegated to an AI agent.

---

## Vision

The goal is not to build another property-management dashboard or AI chatbot.

The goal is to build an **AI operator for the home**.

Instead of:

```text
User → App → Information → User performs the action
```

AI HomeOps explores:

```text
User
  ↓
Goal / Incident
  ↓
AI Operator
  ↓
Understand → Plan → Coordinate → Act
  ↓
Human approval when required
  ↓
Execute → Verify → Learn
```

The system should be capable of managing workflows that may last hours, days, or even weeks.

---

## Example

An owner reports:

> "There is humidity on this wall. Take care of it."

AI HomeOps could:

```text
Create incident
      ↓
Collect context
      ↓
Inspect property history
      ↓
Determine required professional
      ↓
Find providers
      ↓
Request quotes
      ↓
Compare responses
      ↓
Ask owner for approval
      ↓
Coordinate property access
      ↓
Schedule intervention
      ↓
Monitor execution
      ↓
Collect evidence
      ↓
Update property history
```

If something changes — for example, the professional cancels, the diagnosis changes, or the final cost exceeds the approved amount — the agent must be able to **replan or escalate the decision to a human**.

---

## Human-Agent Collaboration

AI HomeOps assumes that managing physical assets cannot be completely automated.

AI can provide:

- Persistent memory
- Planning
- Information retrieval
- Communication
- Scheduling
- Provider coordination
- Workflow orchestration
- Monitoring
- Documentation
- Replanning

Humans provide:

- Physical presence
- Access to the property
- Professional expertise
- Inspection
- Repairs
- High-impact decisions
- Final authority

The objective is therefore not full autonomy.

The objective is **effective collaboration between AI agents and humans**.

---

## Home Twin

Each property is represented by a persistent **Home Twin**.

The Home Twin acts as the long-term memory of the property.

```text
Home Twin
│
├── Property
│   ├── Location
│   ├── Rooms
│   ├── Equipment
│   └── Installations
│
├── People
│   ├── Owners
│   ├── Trusted contacts
│   └── Key holders
│
├── Professionals
│
├── Documents
│   ├── Manuals
│   ├── Insurance
│   ├── Invoices
│   └── Warranties
│
├── Maintenance
│
├── Incidents
│
├── Projects
│
└── Lifecycle history
```

Information stored in the Home Twin should maintain its **source, evidence, and confidence whenever possible**.

For example:

```text
Water heater replaced
Date: 2025-06-14
Provider: Example Plumbing
Cost: €680
Evidence: invoice_2025_0614.pdf
Warranty: 3 years
Confidence: 0.99
```

This provides traceability and helps reduce the risks associated with AI-generated information.

---

## Agentic Workflow

The core workflow being explored is:

```text
Event / Goal
     ↓
Context
     ↓
Planner
     ↓
Specialized capabilities
     ↓
Tool execution
     ↓
Policy / Authorization
     ↓
External action
     ↓
Observation
     ↓
Replanning
     ↓
Completion
     ↓
Memory update
```

A key research challenge is supporting **long-running agentic workflows involving multiple humans and external systems**.

---

## Human-in-the-Loop

Not every action should have the same level of autonomy.

AI HomeOps will explore different authorization policies.

For example:

| Action | Example autonomy |
|---|---|
| Read property documentation | Automatic |
| Create maintenance task | Automatic |
| Contact provider | Automatic / configurable |
| Request quote | Automatic |
| Schedule provisional visit | Configurable |
| Approve €50 expense | Policy dependent |
| Approve €1,000 repair | Human approval |
| Change insurance policy | Human approval |

The system should know when it can act autonomously and when it must stop and request authorization.

---

## Research Question

The project investigates the following question:

> **To what extent can an agentic AI system autonomously coordinate real-world property maintenance workflows involving homeowners, trusted contacts, and service providers while maintaining traceability and human control?**

---

## Evaluation

AI HomeOps will be evaluated using realistic maintenance scenarios.

Examples include:

- Simple plumbing repair
- Electrical fault
- Humidity investigation
- Provider cancellation
- Unexpected increase in repair cost
- Unavailable key holder
- Incorrect initial diagnosis
- Conflicting provider recommendations
- Work reported as completed without sufficient evidence

Possible metrics include:

- Task completion rate
- Percentage of workflow completed autonomously
- Number of human interventions
- Correct tool selection
- Planning accuracy
- Recovery from unexpected events
- Policy violations
- Evidence traceability
- Execution cost
- Token / model cost
- Time to resolution

Different architectures may be compared, for example:

```text
LLM
vs.
LLM + RAG
vs.
LLM + RAG + Home Twin
vs.
Agentic AI + Home Twin + Tools
```

---

## Initial Scope

The first version focuses on one primary capability:

> **Coordinate a maintenance or repair request for a remote property from incident creation to resolution.**

### In scope

- Property knowledge base
- Document ingestion
- RAG
- Persistent Home Twin
- Incident management
- Agent planning
- Tool usage
- Provider coordination
- Human approval
- Long-running workflows
- Replanning
- Audit trail
- Evaluation framework

### Future possibilities

Not required for the initial MVP:

- Computer vision
- IoT sensors
- Automatic anomaly detection
- Predictive maintenance
- Total cost of ownership
- Expense forecasting
- Smart-home integration
- Automated payments
- Professional marketplace
- Additional asset types

---

## Repository Structure

```text
ai-homeops/
├── README.md
│
├── docs/
│   ├── research/
│   ├── market-analysis/
│   ├── product/
│   ├── architecture/
│   ├── adr/
│   └── tfm/
│
├── src/
│
├── tests/
│
├── experiments/
│
├── evals/
│
└── infra/
```

### `docs/research`

Academic papers, agentic AI research, RAG research, long-running agent workflows, and related technical investigations.

### `docs/market-analysis`

Market research, competitors, customer problems, interviews, and business-model hypotheses.

### `docs/product`

Product vision, personas, use cases, user journeys, requirements, and MVP definition.

### `docs/architecture`

System architecture and technical designs.

### `docs/adr`

Architecture Decision Records documenting important technical decisions and their rationale.

### `experiments`

Experiments performed during development.

### `evals`

Evaluation datasets, scenarios, benchmarks, and results.

### `docs/tfm`

Material that will eventually support the Master's Final Project report.

---

## Project Status

**Status:** Discovery / Research

Current focus:

```text
Problem validation
        ↓
Market research
        ↓
Use-case definition
        ↓
MVP definition
        ↓
Architecture
        ↓
Experiments
        ↓
Implementation
        ↓
Evaluation
        ↓
TFM
```

The project is intentionally being developed iteratively. Architecture and technology choices will be documented as decisions are made rather than assumed upfront.

---

## Principles

AI HomeOps is being developed around several principles:

**Agentic, not conversational**

The system should perform work rather than merely explain how the user could perform it.

**Human authority**

Consequential decisions remain under explicit human control.

**Traceability**

Actions and important claims should be linked to their evidence.

**Persistent memory**

The system should understand the history of the property across months or years.

**Failure is expected**

Real-world workflows change. Providers cancel, prices change, people become unavailable, and diagnoses can be wrong.

The system must be able to recover and replan.

**Evaluate, don't just demo**

The project should produce measurable evidence about the capabilities and limitations of agentic AI systems.

---

## Disclaimer

AI HomeOps is currently an experimental research project.

It should not be considered a replacement for qualified property-management, maintenance, legal, insurance, electrical, plumbing, or other professional services.