# ADR 0002: Python with FastAPI for Backend

Status: Accepted

## Context

The project requires a robust, scalable, and maintainable architecture to handle complex agentic workflows, property data management, and a responsive user interface. We need to choose a primary programming language and framework.

## Decision

We will adopt a **Python-centric stack** for the backend and **Next.js** for the frontend.
- **Frontend:** Next.js (React framework).
- **Backend:** Python with **FastAPI**.

Rationale:
- **AI Ecosystem:** Python is the industry standard for AI and Agentic systems. Libraries such as LangChain, LlamaIndex, CrewAI, and Hugging Face provide native, mature support that is far more advanced than the JavaScript/TypeScript ecosystem.
- **Asynchronous Performance:** FastAPI offers high-performance asynchronous capabilities (asyncio), which are ideal for managing many concurrent agent tasks and external API calls.
- **Data Processing:** Python's rich ecosystem (Pandas, Pydantic, etc.) is superior for handling complex document ingestion and data manipulation, which are core to the "Home Twin" concept.
- **Developer Experience:** While the frontend remains in TypeScript, the backend will use Python's type hints and robust async patterns, providing a high degree of safety and clarity.

## Alternatives considered

- **Nest.js (TypeScript):** While it provides a strong enterprise architecture and shared types with the frontend, it lacks the depth and community support in the AI/LLM space that Python offers.
- **Django:** Considered for its "batteries-included" approach, but FastAPI was selected for its superior performance in asynchronous contexts and cleaner API design for microservices.

## Consequences

- We must ensure a clean contract (e.g., OpenAPI/Swagger) between the Python backend and the Next.js frontend to maintain type safety where possible.
- The monorepo will host two different language ecosystems, requiring careful configuration of linting, testing, and deployment pipelines.
- The project will benefit from immediate access to the latest AI research and tools.
