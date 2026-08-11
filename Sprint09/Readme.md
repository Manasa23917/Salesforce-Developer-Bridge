# Sprint 09 – Building Interactive Lightning Web Components

# Student Placement Portal

## 📌 Project Overview

This project is part of **Sprint 09 – Building User Experiences with Lightning Web Components (LWC)**.

The purpose of this sprint is to connect the backend architecture of the Placement Management System with a user-facing Salesforce interface.

In the previous stages of the project, the system was developed with business rules, Apex services, SOQL, DML, triggers, and asynchronous processing.

In this sprint, the system becomes accessible to students through **Lightning Web Components**.

The main goal is not simply to create an attractive UI. The goal is to create a **clear, interactive, reusable, and maintainable business interface**.

The student should be able to interact with the Placement Management System without needing to understand Salesforce objects, Apex classes, SOQL, triggers, or backend architecture.

---

# 🎯 Sprint Objective

The main objective of this sprint is to build an interactive **Student Placement Portal**.

The portal should allow students to:

- View eligible job opportunities
- View important job information
- View job details
- Apply for eligible jobs
- Receive clear feedback after an action
- Understand when an application is being processed
- Understand whether an application succeeded or failed
- Avoid accidental repeated submissions

The complete architecture connects:

```text
Student
   ↓
Lightning Web Component
   ↓
Apex Controller
   ↓
Service Layer
   ↓
Business Rules
   ↓
SOQL / DML
   ↓
Salesforce Database
