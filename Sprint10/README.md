# Sprint 10 – LWC Component Communication, Forms, LDS & Reusable Architecture

## Chapter 10 – Building Components That Think Together

This sprint extends the **Student Placement Portal** from a collection of individual Lightning Web Components into a connected and reusable Salesforce application.

The main focus is **LWC component communication, form handling, Lightning Data Service, reactive data, reusable components, UI states, and application architecture**.

---

# 1. Sprint Objective

The objectives of Sprint 10 are:

- Design LWCs as a complete application
- Understand Parent → Child communication
- Understand Child → Parent communication
- Use `@api` public properties
- Use Custom Events
- Design meaningful event contracts
- Build forms using Lightning Base Components
- Implement client-side validation
- Understand server-side validation
- Understand Lightning Data Service (LDS)
- Decide between LDS and Apex
- Understand reactive data
- Refresh dependent components after updates
- Build reusable components
- Handle Loading, Success, Empty and Error states
- Avoid unnecessary component coupling
- Avoid "God Components"
- Integrate multiple LWCs into one workflow

---

# 2. Project

## Student Placement Portal

The Student Placement Portal manages:

- Student profiles
- Eligible jobs
- Job details
- Job applications
- Application status
- Offers
- Student updates

The application uses:

```text
LWC
 ↓
Apex Controller
 ↓
Service Layer
 ↓
Salesforce Database
3. Component Architecture

The planned component structure is:

StudentPortal
│
├── StudentSummary
│
├── StudentProfile
│
├── EligibleJobs
│   │
│   ├── JobCard
│   └── EmptyState
│
├── MyApplications
│   │
│   ├── ApplicationCard
│   └── EmptyState
│
└── OfferSummary
    │
    └── StatusBadge

Each component has a focused responsibility.

4. Component Responsibilities
StudentPortal

Main parent/coordinator component.

Responsibilities:

Coordinate child components
Maintain shared state where appropriate
Handle child events
Pass data to child components
Coordinate refresh operations
StudentSummary

Displays:

Student Name
Branch
CGPA
Skills
Other student information
StudentProfile

Responsible for:

Loading student information
Displaying current values
Editing profile information
Validating fields
Saving changes
Displaying success/error messages
EligibleJobs

Responsible for:

Displaying eligible jobs
Loading job data
Handling loading state
Handling empty state
Handling errors
Refreshing when student information changes
JobCard

Reusable component for displaying one job.

Displays:

Company
Job Role
Package
Location
Deadline

Actions:

View Details
Apply
Favorite (optional)
MyApplications

Displays applications submitted by the student.

Responsibilities:

Load applications
Display application status
Handle empty state
Refresh after a new application is created
ApplicationCard

Displays individual application information.

Example:

Company: ABC Technologies
Role: Salesforce Developer
Status: Applied
OfferSummary

Displays offer-related information.

StatusBadge

Reusable component for displaying statuses.

Can be used by:

ApplicationCard
InterviewCard
OfferCard
EmptyState

Reusable component for displaying meaningful empty states.

Example:

No Eligible Jobs

No eligible opportunities are available right now.

Keep your profile updated and check again
as new companies are added.
5. Parent → Child Communication

Parent-to-child communication is used when the parent has information that the child needs.

Parent
  |
  | Data
  ↓
Child

LWC uses @api for public properties.

Child JavaScript
import { LightningElement, api } from 'lwc';

export default class JobDetails extends LightningElement {
    @api job;
}
Parent HTML
<c-job-details
    job={selectedJob}>
</c-job-details>

The parent passes the selected job to the child.

6. Why Parent → Child Communication?

If the parent already has job information, the child should not unnecessarily retrieve the same data again.

Instead:

Salesforce
    ↓
Parent
    ↓
Child

Benefits:

Less unnecessary data retrieval
Clear data ownership
Lower coupling
Better maintainability
Better component reuse
7. Child → Parent Communication

A child communicates with its parent using Custom Events.

Child
  |
  | Custom Event
  ↓
Parent

Example:

this.dispatchEvent(
    new CustomEvent('viewdetails', {
        detail: {
            jobId: this.job.Id
        }
    })
);

Parent:

<c-job-card
    job={job}
    onviewdetails={handleViewDetails}>
</c-job-card>

Parent JavaScript:

handleViewDetails(event) {
    const jobId = event.detail.jobId;

    // Parent decides what to do
}
8. Engineering Principle
Children Report Events. Parents Coordinate Behaviour.

A child should not directly modify the parent's state.

Instead:

Child
 ↓
"Something happened"
 ↓
Parent
 ↓
"Decides what to do"

This prevents tight coupling between components.

9. JobCard Events

The JobCard component supports:

viewdetails

Used when the user wants to view job details.

apply

Used when the user clicks Apply.

favorite

Optional stretch functionality.

Example:

this.dispatchEvent(
    new CustomEvent('apply', {
        detail: {
            jobId: this.job.Id
        }
    })
);
10. Event Contract

An event should accurately describe what happened.

For example:

applyclicked

means:

The user clicked Apply.

But:

applicationsubmittedsuccessfully

should not be used by a child that only knows that the button was clicked.

The child does not know whether Salesforce successfully created the application.

Therefore:

User Intent
     ≠
Business Outcome

Good event design communicates facts and avoids assumptions.

11. Lightning Base Components

Salesforce provides reusable Lightning Base Components.

Examples:

lightning-button
lightning-card
lightning-input
lightning-combobox
lightning-textarea
lightning-checkbox-group
lightning-radio-group

Example:

<lightning-input
    label="Phone"
    value={phone}
    onchange={handlePhoneChange}>
</lightning-input>

These components provide standard Salesforce styling and behaviour.

Engineering Principle

Reuse the platform before reinventing the platform.

12. Student Profile Form

The Student Profile form contains:

Field	Type	Required
Name	Text	Yes
Phone	Text	Yes
Email	Email	Yes
Branch	Picklist	Yes
CGPA	Number	Yes
Skills	Long Text	No
Preferred Location	Picklist	No

The form should:

Load existing student information
Display current values
Allow editing
Validate fields
Save changes
Display success
Display errors
Refresh dependent information
13. Form Handling

Example:

handlePhoneChange(event) {
    this.phone = event.target.value;
}

handleEmailChange(event) {
    this.email = event.target.value;
}

For larger forms, a structured/generic change-handling approach can be considered, but unnecessary abstraction should be avoided for small forms.

14. Client-Side Validation

Client-side validation improves user experience.

Examples:

Required fields
Email format
CGPA range
Phone format

Example:

handleSave() {
    const inputs = this.template.querySelectorAll(
        'lightning-input, lightning-combobox'
    );

    let isValid = true;

    inputs.forEach(input => {
        if (!input.reportValidity()) {
            isValid = false;
        }
    });

    if (!isValid) {
        return;
    }

    // Continue save
}
