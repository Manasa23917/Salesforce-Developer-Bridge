# Salesforce Developer Bridge Program – Day 1

## 📌 Overview

Day 1 of the Salesforce Developer Bridge Program focused on strengthening the core Salesforce development skills required for building real-world applications.

The main topics covered were:

- Salesforce Data Modeling
- Object Relationships
- Apex Basics
- SOQL
- Apex Triggers
- Trigger Handler Classes
- Lightning Web Components (LWC)

The hands-on activities were completed using a Salesforce Trailhead Playground.

---

# 🎯 Day 1 Objectives

- Design and create a Salesforce data model.
- Understand Custom Objects and Object Relationships.
- Practice Apex classes, variables, and database operations.
- Write and execute SOQL queries.
- Understand Apex Trigger events.
- Implement Trigger logic using a separate Handler Class.
- Build a basic Lightning Web Component.
- Understand how Salesforce automation works in real-world scenarios.

---

# 🧰 Tools & Technologies

- Salesforce
- Trailhead Playground
- Apex
- SOQL
- Apex Triggers
- Trigger Handler Class
- Lightning Web Components (LWC)
- Developer Console
- Lightning App Builder
- VS Code
- Salesforce CLI

---

# 📚 Block 1 – Data Model Refresh

## Task 1: Design a Mini Data Model

### Scenario

For this task, I selected the:

**College Library Management System**

### Custom Objects

The data model contains the following custom objects:

- `Books__c`
- `Members__c`
- `Issue_Record__c`

### Relationships

`Issue_Record__c` connects the library books and members.

The Issue Record represents which member has issued which book.

### Basic Data Model

```text
Books
   |
   | Lookup
   |
Issue Record
   |
   | Lookup
   |
Members
