# 🚀 Sprint 27 — LWC Parent–Child Component Communication

> **Building reusable Lightning Web Components that communicate, collaborate, and work together.**

---

## 📌 Overview

**Sprint 27** focuses on one of the most important concepts in Salesforce Lightning Web Components (LWC):

> **Parent–Child Component Communication**

In this hands-on sprint, a reusable **Job Card** child component is created to display job information. A **Student Portal** parent component retrieves Job records from Salesforce and passes them to the child component.

The child component communicates user actions back to the parent using **Custom Events**.

This sprint demonstrates how multiple LWCs can work together as a reusable and maintainable component architecture.

---

## 🎯 Learning Objectives

By completing this sprint, I learned how to:

- ✅ Create reusable Lightning Web Components
- ✅ Build Parent and Child LWC relationships
- ✅ Pass data from Parent → Child
- ✅ Use `@api` for public properties
- ✅ Create and dispatch Custom Events
- ✅ Communicate from Child → Parent
- ✅ Handle Custom Events in the Parent
- ✅ Retrieve Salesforce records using Apex
- ✅ Use `@wire` to call Apex
- ✅ Display multiple Salesforce records dynamically
- ✅ Deploy LWC and Apex components using Salesforce CLI
- ✅ Test component communication in Salesforce

---

# 🏗️ Architecture

The application follows a simple Parent–Child architecture:

```text
                    ┌───────────────────────┐
                    │    StudentPortal      │
                    │       (Parent)        │
                    │                       │
                    │  Retrieves Job__c     │
                    │      records           │
                    └───────────┬───────────┘
                                │
                         job={job}
                                │
                                ▼
                    ┌───────────────────────┐
                    │       JobCard         │
                    │       (Child)         │
                    │                       │
                    │ Displays Job Details  │
                    │                       │
                    │ [View Details]        │
                    │ [Apply]               │
                    └───────────┬───────────┘
                                │
                   Custom Events│
                                ▼
                    ┌───────────────────────┐
                    │    StudentPortal      │
                    │                       │
                    │ handleViewDetails()   │
                    │ handleApply()         │
                    └───────────────────────┘
