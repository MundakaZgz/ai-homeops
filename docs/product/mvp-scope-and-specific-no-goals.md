# MVP scope and explicit non-goals

Status: scope definition draft based on the agreed product requirements. Proposed limits and unresolved decisions are identified below; they are not silently treated as approved requirements.

Related document: [Project goals and success criteria](goals-and-success-criteria.md), which defines the product purpose, detailed acceptance scenarios, and measurement rules.

## 1. MVP outcome

A family can describe work needed at its second home, receive a proposal obtained through an agent's conversation with a local professional, and accept a quote and appointment compatible with a member's stay. The appointment becomes confirmed only when the professional confirms the accepted terms.

The MVP also handles reminders, cancellation when a stay changes or a member requests it, and subsequent rescheduling. For work requiring several professionals, the system identifies dependencies and coordinates a simple sequential plan rather than treating each appointment as an independent success.

The product must support these journeys through mobile and desktop browsers. The technology stack remains pending the corresponding ADR.

## 2. Users and operating boundaries

| Area | MVP boundary | Decision status |
| --- | --- | --- |
| Users | Family members associated with the property, with equal authority to decide and take responsibility for payment | Defined |
| Appointment contact | An identified family member available to receive the professional and accept the proposal | Defined |
| Providers | Local professionals contacted through their published channels; no application account required | Defined |
| Property coverage | Pilot with one second home and several family members | Proposed pilot limit |
| Service coverage | One geographical area and a small set of service categories | Proposed limit; specific area and categories pending |
| Provider communication | Discover forms, email, or WhatsApp; implement one operational channel including replies, confirmations, and cancellations first | Proposed limit; channel pending |
| Calendar | Manage stays and receiving availability in the application | Defined baseline; external integration pending |
| Platforms | Responsive web on mobile and desktop; validate Safari on iPhone and Chrome on Android | Defined |

Equal family permissions do not imply public access: members must be identifiable and access must be limited to the family associated with the property. The access mechanism will be chosen during technical design.

## 3. Included capabilities

| ID | Capability | Minimum included behavior |
| --- | --- | --- |
| MVP-01 | Property and family | Record the property and location, associate family members, and identify who receives the professional for each appointment |
| MVP-02 | Assisted task preparation | Create and review tasks; an agent asks for missing details about the change or fault; support image attachments and an urgent tag |
| MVP-03 | Stays and availability | Create, edit, and cancel stays; record availability to receive professionals; revalidate affected appointments when a stay changes |
| MVP-04 | Task analysis | Identify required trades or skills and missing information; detect dependencies and ask whether all related tasks are necessary before booking |
| MVP-05 | Local provider discovery | Find candidates serving the area and required work, retain sources, deduplicate candidates, and identify published contact channels |
| MVP-06 | Provider conversation | Ask about approximate availability without disclosing exact stay dates; if compatible, discuss specific dates, quote, scope, and terms; associate replies with the correct task and provider |
| MVP-07 | Proposal and acceptance | Present provider-supplied scope, quote, validity, conditions, and schedule to the receiving member; record acceptance or rejection; obtain renewed acceptance when terms change |
| MVP-08 | Appointment confirmation | Request provider confirmation after member acceptance; keep pending and confirmed states distinct and retain evidence; prevent duplicate bookings from repeated events |
| MVP-09 | Sequential plans | Validate order, duration, buffers, and family availability for dependent tasks; present the whole required plan and quotes; count success only when all required appointments are confirmed |
| MVP-10 | Email reminders | Send appointment reminders to the receiving family member with a link to view and explicitly request cancellation; opening the link alone must not cancel |
| MVP-11 | Cancellation and rescheduling | Initiate provider cancellation from a member request or an invalidated stay; keep cancellation pending until confirmed; place the task on hold and resume coordination when a compatible stay exists |
| MVP-12 | Mobile journeys | Support task preparation, image attachments, calendar or agenda, proposals, plans, and appointment actions with readable content and touch controls; preserve email-link destinations through sign-in |
| MVP-13 | Status and evidence | Show current task, proposal, plan, and appointment states and outstanding issues; retain the links and events needed to explain outcomes and calculate the agreed metrics |

The agents' responsibilities are product capabilities, not a decision about how many agents, services, or frameworks to implement.

## 4. Required exception handling

- **Incomplete task:** ask the member for clarification; distinguish known facts from assumptions. Urgency does not remove acceptance or dependency checks.
- **No suitable provider or availability:** show a pending reason and try another candidate within the pilot's contact limits.
- **Unsupported channel or no reply:** make the limitation or waiting state visible; apply a defined response deadline instead of indefinite outreach. Sending a form is not evidence of receiving a quote.
- **Visit needed before quoting:** present a separate visit proposal with any cost; do not count it as confirmation of the original work.
- **Rejected, expired, or changed proposal:** do not book under unaccepted terms; request a new decision when needed.
- **Incomplete dependent plan:** show partial progress, ask for a decision where necessary, and review or cancel affected bookings if a required provider cannot confirm.
- **Changed stay or delayed preceding task:** revalidate affected appointments and dependencies, then coordinate the necessary cancellation or rescheduling. A reported delay must be actionable even though automatic verification of physical work is outside scope.
- **Unresolved cancellation:** preserve the pending state and inform the member about missing replies, costs, or obstacles. Do not accept a new charge automatically or conceal a pending cancellation when rescheduling.
- **Duplicate events:** repeated replies, acceptances, calendar changes, or cancellation requests must not create duplicate bookings, requests, or success counts.

Expected member clarification and acceptance are part of normal use. Exceptional manual intervention to correct or replace the agent must be visible and measured, rather than hidden as autonomous completion.

## 5. Explicit non-goals

The following are not required for MVP completion. Items marked as proposed deferrals still need a scope decision.

| ID | Non-goal | Boundary |
| --- | --- | --- |
| NG-01 | Payment processing, invoicing, and expense splitting | Members may authorize and pay for work outside the application; the MVP coordinates quotes and appointments |
| NG-02 | External receiver roles or differentiated family approval hierarchies | All associated family members have equal decision authority; there is no separate door-opening role |
| NG-03 | Native mobile applications, mandatory installation, and offline operation | Mobile access is delivered through the responsive website; PWA installation is optional future work |
| NG-04 | Physical work verification and post-service quality evaluation | A confirmed appointment is the MVP success boundary; it does not prove the work was performed |
| NG-05 | Automated optimization of complex renovations | Simple dependencies and sequential plans are included; global optimization and combining several tasks into one visit are excluded |
| NG-06 | Autonomous commitments without member acceptance | The agent may inquire and prepare proposals but cannot book under unaccepted terms or accept new charges automatically |
| NG-07 | Unlimited provider outreach | Candidates, follow-ups, and waiting periods are bounded by pilot settings |
| NG-08 | Multi-property management | Proposed deferral: evaluate the first version with one property rather than adding a portfolio management experience |
| NG-09 | Complete support for every provider channel | Proposed deferral: deliver one operational channel first; finding another contact channel does not imply it is integrated |

External calendar synchronization remains an open decision, not an agreed exclusion. Email reminders to family members are required regardless of the provider conversation channel selected.

## 6. Delivery sequence within the MVP

These increments organize implementation; later increments remain part of the stated MVP scope.

1. **Single-task coordination:** property and members, assisted task preparation, stays, local discovery, one provider conversation channel, proposal acceptance, and provider confirmation. Make the journey usable on mobile from the start.
2. **Changes and recovery:** email reminders, explicit cancellation, calendar-triggered cancellation, waiting states, and rescheduling with renewed acceptance.
3. **Dependent tasks:** a simple sequential plan involving several trades, complete-plan acceptance and confirmation, and recovery when one appointment or dependency changes.

Capture status and measurement events throughout all increments. Do not postpone evidence collection until the pilot.

## 7. Scope validation and completion criteria

The implementation satisfies the MVP scope when:

- A single-task journey reaches a real provider-confirmed appointment with recorded member acceptance and compatible receiving availability.
- A calendar change and an explicit cancellation from an email reminder both initiate the cancellation process, distinguish pending from confirmed cancellation, and leave the task available for rescheduling.
- A task on hold can obtain a new accepted proposal and provider-confirmed appointment when a suitable stay exists.
- A representative sequential plan respects dependencies and is never reported as complete while a required appointment remains unconfirmed.
- Missing information, no response, rejected proposals, partial confirmations, and duplicate events produce the expected visible outcomes.
- The agreed mobile and desktop journeys pass the acceptance scenarios in the goals document, with devices and versions recorded.
- Outcomes can be traced to recorded evidence and measured using the definitions in the goals document. Simulated provider interactions are identified separately from real coordination.
- Another person can run and evaluate the application using the project documentation.

These are delivery criteria, not claims that the features already exist or have been tested. Sustained success targets will be set using the pilot baseline.

## 8. Decisions still needed to finalize scope

| Decision | Why it matters |
| --- | --- |
| Confirm the proposed one-property pilot boundary and select area and service categories | Defines which real tasks and providers the pilot must cover |
| Confirm the one-channel approach and choose search source and provider channel | Determines how real discovery, replies, confirmation, and cancellation can be demonstrated |
| Decide whether external calendar integration is necessary for the MVP | Determines whether changes originate only within the application or must also be synchronized |
| Set outreach limits, response deadlines, reminder timing, and cancellation escalation deadlines | Makes waiting, reminders, and recovery behavior testable |
| Select the representative sequential plan and its supported complexity | Bounds dependency coordination without removing it from the MVP |
| Define pilot participants, duration, and minimum evaluable attempts | Enables a meaningful assessment of the delivered scope |

The technology stack will be selected in an ADR, without changing these product requirements by implication. A future scope change should update this document and the corresponding acceptance criteria in the goals document together.
