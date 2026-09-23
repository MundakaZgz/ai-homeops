# Project goals and success criteria

Status: proposed MVP scope based on the product vision. Provider discovery approach defined: local search and conversations through providers' contact channels. Pending: specific search source, first operational channel, pilot area and service categories, and numerical targets.

## 1. Project purpose

Build a web application that helps people who share a second home coordinate work in advance, matching local service providers' availability with the planned stays of family members who can receive them.

The application will be accessible through mobile and desktop browsers, with a responsive interface for both screen sizes. Mobile access is part of the MVP.

The application will bring together a property, its members, a task list, and a calendar of stays. It will analyze each task to identify the professional skills required, find local providers, and present a quote and proposed appointment to the person who will be at the property. Confirmation with the provider will only be requested after that person accepts.

The search will start with professionals near the property. The system will find their published contact forms, email addresses, or WhatsApp channels. An AI agent will manage the conversation to explain the work, answer questions using the available information, and obtain a quote and availability. Providers will be able to reply through the established channel without registering in the application.

The expected value is to reduce manual coordination and use planned stays to address pending work. This improvement must be validated during the pilot.

The technology stack remains undecided until the corresponding ADR is written, including backend and frontend languages and frameworks. The project will use a monorepo, follow Clean Architecture, and keep its documentation in `doc/`.

The monorepo structure and Clean Architecture remain project guidelines; product success will be evaluated through the outcomes users achieve.

## 2. First objective: MVP

Deliver an initial version that allows a family to describe a task for their second home with an agent's help and coordinate it through to a provider-confirmed appointment, with a quote accepted by a member whose stay covers the appointment. The journey will include email reminders, cancellation, and waiting for rescheduling when a stay changes. For work requiring several trades, it must identify and respect dependencies before confirming the plan, without manual intervention from the development team to complete the journey.

Journey definition:

| Element | Definition |
| --- | --- |
| Target user | People who share a second home and can receive professionals during their stays |
| Problem | Coordinating work, professionals, quotes, and presence at the property in advance |
| Main task | Arrange an appointment for pending work, compatible with a stay and with an accepted quote |
| Start | A member registers a task and requests coordination |
| Successful outcome | The provider confirms the appointment and accepted terms; the appointment is linked to the task and the person who will receive them |
| Validation | Evidence of member acceptance, provider confirmation, and compatibility with the current stay |
| Evaluation environment | A pilot limited to one property with several members; area, categories, and providers to be defined |

### Minimum scope

- Allow users to complete the main journeys in a mobile browser through a responsive interface and touch controls.
- Create a property with its location and associate family members with equal permissions to make decisions and take responsibility for payment. Roles for non-family members who only receive the professional are not included; processing payments within the application remains outside the MVP.
- Register tasks with a complete description of the change or fault, assisted by an agent that asks for missing information. Allow image attachments, an urgent tag, and status tracking.
- Record each member's stays and availability to receive a professional. Being at the property does not imply being available at any time.
- Identify the skills needed for each task; ask for clarification when the description is insufficient.
- Find nearby professionals who cover the area and required skills, retaining the source for each candidate.
- Identify their published contact channels and use an operational channel to start and continue a conversation with an AI agent.
- Obtain the provider's quote and availability, including terms and validity, and match them against a member's availability.
- Present the proposal to that member for acceptance or rejection.
- After acceptance, request confirmation from the provider and record their response. Member acceptance alone does not confirm the appointment.
- Show the outcome to property members and persist evidence of the journey.
- Send email reminders to the family member who will receive the professional, with a link to request cancellation.
- Detect calendar changes that invalidate the stay associated with an appointment, initiate cancellation with the professional, and place the task on hold for rescheduling.
- Detect work involving multiple dependent tasks, ask the member whether they require a joint plan, and coordinate appointments in the required order.
- Record the events needed for metrics and document how to run and evaluate the application.

The proposal is to start with one area and a small number of work categories, with one task, one provider, and one receiving member per appointment. Several candidates may be evaluated for the same task, keeping their proposals and conversations separate. A system-generated cost estimate does not replace a provider's quote.

### Mobile access

The MVP will be delivered as a responsive website, accessible through a link without mandatory installation. The main journeys will be designed for small screens: creating tasks with the agent's help, attaching images from a phone, managing stays, reviewing plans and quotes, accepting proposals, and viewing or cancelling appointments.

The calendar will provide an agenda view or an equivalent usable on mobile. Forms, conversations, and proposals must be readable and operable without a mouse or hover-only actions. Text and controls must remain visible when using the phone's keyboard, and essential information must not require horizontal scrolling.

Email reminder links will open the relevant appointment in a mobile-friendly view. If sign-in is required, the destination will be preserved so users can continue with that appointment afterwards. Cancellation will still require the explicit confirmation described in this document.

MVP validation will include Safari on iPhone and Chrome on Android, as well as desktop; specific versions and devices will be recorded when tests are run. PWA installation, native applications, and offline operation remain possible extensions rather than MVP requirements.

### Finding and communicating with professionals

1. Identify the trade or skills and service area required for the task.
2. Search for nearby candidates and check that the information found indicates they serve that area and type of work. Proximity alone does not guarantee coverage or availability.
3. Find each professional's published channels: contact form, email, or WhatsApp. Record the source and avoid duplicate candidates.
4. Start a conversation through a supported channel. The agent introduces itself as a coordination assistant, describes the work, and asks about approximate availability around the planned stays without revealing their exact dates or the family calendar. If availability is incompatible, find another candidate. Otherwise, discuss specific dates and request a quote and terms.
5. Associate replies with the correct professional and task. Ask for missing information that only a member knows rather than inventing it; request clarification for ambiguous replies.
6. Build a proposal using information confirmed by the professional: scope, amount and currency, terms, validity, and schedule, including expected duration when needed to check availability.
7. Present it to the person who will receive the professional. After acceptance, request provider confirmation and record evidence of the response.

The agent may search, make inquiries, and prepare proposals within the requested coordination. Booking or commissioning work requires prior member acceptance of the specific terms. If the provider changes those terms, renewed acceptance is required. If a visit is needed to prepare a quote, the visit proposal will be distinguished from commissioning the work, and any potential visit cost will be shown.

Submitting a form is not the same as maintaining a conversation: a return channel must allow replies to be received and associated with the request. If a channel is not integrated or requires manual intervention, that limitation is recorded and the journey is not presented as autonomous.

**Proposed MVP scope reduction:** detect available channels and initially enable one channel for an end-to-end conversation; add the others later. The initial channel and search source will be selected after checking technical feasibility. This is a scope proposal, not an agreed decision to support all three channels from the start.

The pilot will set limits on candidates contacted per task, follow-ups, and waiting time. A lack of response will leave the attempt pending until the agreed deadline; it will not trigger indefinite outreach.

### Task preparation and family decisions

All family members associated with the property may make decisions and take responsibility for the expense. Each appointment identifies the person who will be available and accept the proposal; equal permissions do not remove the need to know who will receive the professional.

The preparation agent helps complete the description of the change or fault through questions tailored to the work and allows images to be added. It distinguishes supplied facts from inferences awaiting validation. The urgent tag prioritizes coordination but does not authorize bookings without acceptance or remove dependencies between tasks.

### Reminders, cancellation, and rescheduling

The application's calendar will be the reference for stays; integration with external calendars remains undecided. Each relevant change triggers revalidation of linked appointments. If a stay is cancelled or no longer covers an appointment, the same process is initiated automatically as when a family member requests cancellation through a reminder.

- The reminder is addressed to the family member associated with the appointment and includes appointment details and a cancellation link. Lead time and frequency remain to be defined.
- As an implementation criterion, opening the link shows the appointment and allows cancellation to be confirmed; simply opening or automatically previewing the email must not cancel it.
- When cancellation is requested, the appointment moves to **cancellation pending**, and the professional is contacted. The task moves to **awaiting rescheduling**, retaining its link to the previous appointment.
- Only a reply from the professional confirming cancellation allows the appointment to be marked **cancelled**. If they do not respond or report a cost or obstacle, the member is informed and the issue remains visible; it is not treated as resolved, and no new charge is accepted automatically.
- Attendance reminders for the invalidated appointment stop. Repeated calendar events or clicks do not generate duplicate requests.
- When a compatible stay and availability exist, the search or conversation resumes, the quote and terms are revalidated, and renewed acceptance is requested. The new appointment remains linked to the previous one without hiding a pending cancellation.

### Work with dependencies between professionals

The analysis may break down work into several tasks. If it is unclear whether they are useful individually or require the whole set to be completed, the agent asks the family member before booking. Independent tasks that can be coordinated in parallel are distinguished from tasks that require an order and waiting periods.

For example, a renovation might require an electrician, then a builder, then a painter. The specific order and durations must be validated for that work; all three are not automatically assigned the same time slot. The plan includes dependencies, durations, and necessary buffers, as well as family presence for each appointment.

When all tasks are necessary, compatible availability is obtained for the whole set, and the plan and quotes are presented before confirmations are requested. The plan is considered confirmed only when all required professionals have confirmed compatible appointments. Confirmations may arrive at different times: if one fails, the member is informed and affected bookings are reviewed or cancelled, without presenting the whole plan as complete.

If a preceding task is delayed or a stay changes, subsequent tasks are revalidated and the appropriate rescheduling or cancellation is coordinated. The proposed MVP sequence will be simple; automatic optimization of complex renovations is outside this initial scope.

Outside the proposed MVP: payments, invoicing, expense sharing, optimizing several tasks into one visit, and verification that the physical work has been carried out. Support for multiple properties may be added after the pilot.

Secondary features, additional integrations, and optimizations will be decided after validating this journey, unless they are necessary to complete it.

### MVP acceptance criteria

| Scenario | Expected outcome |
| --- | --- |
| A family member uses the application on mobile | They can create a task, answer the agent, attach images, manage stays, and review and accept proposals using touch controls and readable content |
| A plan involving several professionals is viewed on a small screen | The order, dates, quotes, and status of each appointment are distinguishable without losing essential information |
| An email reminder is opened on a phone | The user reaches the correct appointment, with the destination preserved if sign-in is needed, and can confirm cancellation |
| Clear task, available professional, and compatible stay | A quote and appointment are presented; after member acceptance and provider confirmation, the appointment is confirmed with supporting evidence |
| Insufficient description | Clarification is requested before proceeding with an unsupported proposal |
| Task with images and an urgent tag | The agent incorporates the information into task preparation, asks for missing details, and retains urgency without skipping acceptance |
| Initial inquiry to the professional | An approximate period is discussed without sharing exact stay dates; specific dates are discussed only if availability exists |
| No professional or compatible availability | The task remains pending with a visible reason; no quote or appointment is invented |
| A candidate exists but has no supported operational channel | The reason is recorded, and another candidate is sought or intervention requested; the system does not claim a conversation has started |
| An inquiry or form is sent without a reply | The system shows that it is awaiting a response and applies the pilot deadline; sending the inquiry does not count as obtaining a quote |
| A reply contains incomplete information or cannot be associated with a task | Clarification or review is requested; it is not incorporated into a proposal as confirmed information |
| The professional needs to visit the property before quoting | A visit proposal and its terms are explicitly presented; this does not count as a confirmed booking for the original work |
| The member rejects the proposal or it expires | The appointment is not confirmed; the outcome is recorded, and a new proposal may be initiated |
| The member accepts but the provider does not confirm | The appointment remains pending or ends as unconfirmed; it does not count as a success |
| The stay, schedule, or quote changes before confirmation | The proposal is revalidated, and renewed acceptance is requested if accepted terms change |
| Acceptance is repeated or a duplicate reply arrives | No duplicate appointments are created, and success is not counted twice |
| A stay is cancelled or changed and no longer covers the appointment | Cancellation with the professional is initiated, and the task awaits rescheduling |
| A reminder becomes due | The associated family member receives an email with current appointment details and a cancellation link |
| The family member confirms cancellation through the link | The same cancellation process is initiated; repeating the action does not duplicate requests |
| The professional has not yet confirmed cancellation | The appointment shows cancellation pending; the application does not claim it is cancelled |
| A new stay becomes available for a task on hold | Availability and terms are revalidated, and renewed acceptance is obtained before another appointment is confirmed |
| A renovation requires several trades | The agent asks whether the whole set is necessary, validates dependencies, and proposes compatible sequential appointments |
| A required trade has not confirmed or a preceding task is delayed | The plan does not count as a complete success; dependent appointments are reviewed, and the member is informed |

The journey must also work through the interface with real components in the evaluation environment, record each attempt's states, and be reproducible by following the documentation. Simulated providers support development and testing but do not demonstrate real coordination with a professional.

Mobile journeys will be verified in Safari on iPhone and Chrome on Android. Devices, versions, and results will be recorded, including attachments, calendar use, acceptance, and cancellation from email. Desktop checks will complement this validation.

The MVP is considered delivered when these criteria are met. Delivery does not yet demonstrate a sustained success rate with real users.

## 3. Second objective: success after the MVP

Verify that users complete tasks end to end reliably and with reasonable effort. A baseline will first be collected in a pilot; numerical targets and an evaluation period will then be established.

### What E2E task completion means

In the MVP, **completed E2E coordination** starts with a task coordination request and ends with a provider-confirmed appointment, an accepted quote, and a person available to receive the professional. A successful HTTP response, a generated proposal, or member acceptance is insufficient to count as success.

When a request includes several necessary tasks, E2E success is measured for the entire plan: all appointments must be confirmed and respect dependencies. Partial confirmations are recorded as progress, not overall success. Simple tasks and plans with dependencies are reported separately.

Two outcomes will be distinguished: **coordination completed** (appointment confirmed, the MVP objective) and **work completed** (service delivered and subsequently validated by the member, an extension objective). A confirmed appointment will not be presented as work already carried out.

Each attempt will have a unique identifier. Technical retries within the same journey will not create new user attempts. If the user restarts the task after a terminal state, another attempt will be recorded and linked to the previous one where possible.

### Proposed metrics

| Metric | Calculation | What it evaluates |
| --- | --- | --- |
| Completed E2E coordinations | Number of distinct tasks reaching a valid confirmed appointment for the first time | Volume of tasks with coordination resolved, without inflation from retries |
| E2E success rate | Successfully completed attempts / attempts started in the cohort × 100 | Reliability of the complete journey |
| Time to completion | Median and 90th percentile of time from start to success, for successful attempts only | Speed and slow cases |
| Failure rate | Attempts ending in failure / attempts started in the cohort × 100 | Frequency of errors preventing completion |
| Abandonment or expiry rate | Abandoned or expired attempts / attempts started in the cohort × 100 | Journeys that do not reach an outcome |
| Assistance rate | Attempts requiring team intervention / attempts started in the cohort × 100 | Dependence on support to complete tasks |
| Contact coverage | Unique candidates with a supported operational channel / unique candidates evaluated × 100 | Ability to move from search to conversation |
| Response rate | Conversations receiving a professional's reply / conversations started in the cohort × 100 | Contact effectiveness by channel, after the agreed response window |
| Proposal acquisition rate | Conversations producing a usable quote and availability / conversations started in the cohort × 100 | Agent's ability to obtain a proposal the member can evaluate |
| Proposal acceptance rate | Accepted proposals / proposals presented in the cohort × 100 | Suitability of the quote and appointment for the user |
| Provider confirmation rate | Proposals confirmed by the provider / proposals accepted by the member in the cohort × 100 | Conversion from acceptance to an actual appointment |
| Subsequent cancellation rate | Confirmed appointments cancelled before the service / confirmed appointments in the cohort × 100 | Coordination stability; provisional until the service date |
| Resolved cancellation rate | Cancellation requests confirmed by the professional / cancellation requests in the cohort × 100 | Ability to complete cancellation, also reporting pending requests and resolution time |
| Completed rescheduling rate | Tasks on hold after cancellation that achieve valid new coordination / tasks in that cohort with a new compatible stay × 100 | Recovery after calendar changes; also report tasks still without a stay |

As an extension, measure work completed and validated for appointments whose service date has passed. This will require subsequent confirmation from the member.

Always show the numerator, denominator, and period alongside percentages. Separate results by task type and product version; do not mix automated tests with real usage.

### Measurement rules

- A cohort groups attempts started within a defined period.
- Agree on a maximum completion window for each task type. Until that window closes, cohort results are provisional and pending attempts are also reported.
- Each attempt has one terminal state: success, failure, user rejection, or abandonment/expiry. While it can continue, it remains pending with a reason, such as no professional or no stay. Rejection is a user decision and is reported separately from technical failure. Assistance is recorded as an additional attribute; expected member acceptance does not count as assistance.
- Link each attempt to the task, proposals, and appointment. Report both attempts and distinct tasks to make retries visible.
- For dependent plans, link the main request, its tasks, and all appointments. Count plan success once, without adding it to its subtasks as though they were independent requests.
- Also link candidates, channels, and conversations. Follow-ups within a conversation do not count as new contacts; break down contact metrics by channel and measure waiting times for professionals and members separately.
- Expected clarification and acceptance from members are normal interactions. Record exceptional interventions needed to correct or replace the agent separately.
- A subsequent cancellation does not erase the historical confirmation event: it changes the appointment's current state and contributes to its own metric.
- Validate the outcome before recording success. If later review is required, keep the attempt pending until validation.
- Record at least: attempt identifier, task type, version, start time, completion time, state, outcome validation, and assistance indicator. For failures, add an error category.
- Avoid including sensitive user content in measurement events.

### Pending numerical targets

No arbitrary percentages are set before understanding the use case and its baseline.

| Decision | Pending value |
| --- | --- |
| Pilot duration and participants | To be defined |
| Maximum task completion window | To be defined |
| Minimum number of evaluable attempts | To be defined |
| Target volume of completed tasks | To be defined |
| Minimum E2E success rate | To be defined after the pilot |
| Target completion time | To be defined after the pilot |
| Maximum acceptable assistance rate | To be defined after the pilot |
| Period for verifying targets | To be defined |

The post-MVP success criterion will combine minimum volume, success rate, and time and assistance limits over the agreed period. A high number of completed tasks alone does not demonstrate reliability.

## 4. E2E tests versus product metrics

Automated E2E tests verify that defined scenarios work in a controlled environment. E2E product metrics show whether users achieve their goals while using the application. Both forms of evidence will be used and kept separate.

## 5. Pending decisions and completion of this definition task

- Select the pilot area and service categories.
- Choose the specific source for finding local professionals and the first operational conversation channel among forms, email, and WhatsApp, including receiving and associating replies.
- Set the maximum number of candidates contacted per task, follow-ups, and response deadlines for the pilot.
- Define email reminder lead time and deadlines for escalating unanswered cancellation requests.
- Specify whether stays will be managed only in the application's calendar or also through an external integration.
- Select a scenario with several sequential tasks to validate dependency coordination in the pilot.
- Define participants, duration, completion window, and minimum number of pilot attempts.
- Review the proposed scope and subsequently set success thresholds using the baseline.

This task will be complete when the purpose, MVP scope, acceptance scenarios, and pilot plan have been agreed. Post-MVP thresholds may be finalized after the pilot, documenting their values and rationale.
