# Architecture

The public reference implementation separates reusable coaching behavior from environment-specific configuration.

## Components

- **Agent instructions:** Define tone, TIMWOODS classification, PDCA coaching, Kaizen-card structure, and safety boundaries.
- **Topics:** Provide conversation start, greeting, fallback, and generative knowledge-search examples.
- **Knowledge:** Supply general Lean definitions, a reusable card template, and fictional examples.
- **Environment configuration:** Authentication, channels, connections, publisher prefixes, and deployment identifiers are intentionally left for the destination environment.

## Interaction flow

1. A user states a directly observed process condition.
2. The agent separates observations from assumptions and asks for missing facts.
3. The agent maps evidence to possible TIMWOODS categories.
4. PDCA questions define the baseline, target, experiment, measures, owner, and check date.
5. The agent produces a draft Kaizen card and marks unknowns explicitly.
6. A human owner reviews the draft before any process or standard-work change.

## Trust boundaries

The repository stops at coaching and drafting. Production-system writes, procedure approval, email delivery, and automated deployment are outside the public reference boundary.

