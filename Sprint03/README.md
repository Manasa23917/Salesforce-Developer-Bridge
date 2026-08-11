# Salesforce Automation – Flow & Validation Rules

## 📌 Overview

This project is part of my Salesforce Developer learning and focuses on building automation using **Record-Triggered Flows, Validation Rules, and Apex Triggers**.

The objective was to understand how Salesforce automation tools can be used to automate application processing, maintain data quality, send notifications, and create related records.

---

## 🎯 Objectives

- Understand Salesforce automation tools.
- Build a Record-Triggered Flow.
- Automatically populate Application Date.
- Send email notifications.
- Create Validation Rules for data quality.
- Understand Flow vs Trigger use cases.
- Prevent duplicate applications.
- Automatically create an Offer Letter when an application is Selected.
- Understand Salesforce automation execution and possible recursion.

---

## 🛠️ Technologies Used

- Salesforce
- Flow Builder
- Record-Triggered Flow
- Validation Rules
- Apex Triggers
- Salesforce Objects and Fields
- SOQL
- Email Alerts / Email Actions

---

# Part 1 – Salesforce Automation Concepts

### 1. Can a Validation Rule update another field?

No.

A Validation Rule is used to **check whether data meets a condition**.

It can:
- Allow a record to be saved when the condition is false.
- Prevent a record from being saved when the condition is true.
- Display an error message.

It cannot directly update another field.

For updating fields automatically, we can use **Flow, Apex, or other appropriate automation tools**.

### 2. Which executes first: Validation Rule, Flow, or Trigger?

Salesforce automation follows a specific order of execution, and the exact order depends on the type of automation and operation.

For practical understanding:

- Validation Rules validate data during the save process.
- Before-Save Flows can modify field values before the record is saved.
- Apex Triggers execute during the save process.

The important point is that Salesforce has a defined **Order of Execution**, so developers should design automation carefully to avoid conflicts and recursion.

### 3. What is a Record-Triggered Flow?

A Record-Triggered Flow is a Flow that automatically runs when a record is:

- Created
- Updated
- Deleted

It can perform actions such as:

- Updating fields
- Creating related records
- Sending emails
- Calling actions
- Applying business logic

---

# Part 2 – Business Scenario

The Placement Cell requires automation for student applications.

### Business Requirements

1. Send an email to the Placement Officer whenever a student submits an application.
2. Automatically populate Application Date when an application is created.
3. Prevent duplicate applications.
4. Reject applications when the student's CGPA is below the required minimum.
5. Automatically create an Offer Letter when the application Status becomes Selected.

---

# Part 3 – Automation Design

| Requirement | Validation Rule | Flow | Trigger | Reason |
|---|---|---|---|---|
| Reject duplicate applications | ❌ | ❌ | ✅ | Requires checking existing records and preventing duplicate creation |
| Auto-fill Application Date | ❌ | ✅ | ❌ | Flow can automatically populate the field |
| Send Email | ❌ | ✅ | ❌ | Flow can send email notifications |
| Reject low CGPA | ✅ | ❌ | ❌ | Validation Rule can prevent invalid data from being saved |
| Create Offer Letter | ❌ | ✅ | ❌ | Flow can create a related Offer Letter record |

### Design Decision

I prefer **Flow** for straightforward automation such as field updates, email notifications, and creating related records.

I use **Validation Rules** when the main requirement is preventing invalid data from being saved.

**Apex Triggers** are preferred when the requirement involves complex logic or processing that is difficult to achieve efficiently using declarative tools.

---

# Part 4 – Record-Triggered Flow

## Flow Objective

The Record-Triggered Flow was designed to:

1. Automatically populate Application Date when a new Application is created.
2. Send a confirmation email to the Placement Officer.
3. Complete the automation after the required actions are performed.

## Flow Configuration

### Start Element

The Flow starts when a new Application record is created.

### Assignment Element

The Assignment element is used to assign the current date to the Application Date field.

Example:

```text
Application Date = $Flow.CurrentDate
