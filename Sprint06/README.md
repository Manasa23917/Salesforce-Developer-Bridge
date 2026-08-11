# Salesforce Apex Trigger – Automatic Application Validation

## 📌 Project Overview

This project implements an Apex Trigger in Salesforce to automatically validate a student's job application before the application is saved.

The main business rule implemented in this task is:

> A student must have a CGPA of 6.0 or above to submit an application.

This hands-on task is part of **Chapter 6 – Making Software Respond Automatically**, where Apex Triggers are used to respond automatically to business events.

---

## 🎯 Objective

The objective of this task is to:

- Understand Apex Trigger automation.
- Use a `before insert` Trigger.
- Validate Application records automatically.
- Retrieve related Student information using SOQL.
- Check the student's CGPA.
- Prevent invalid Applications from being saved.
- Keep business logic inside a Service class.
- Follow clean and maintainable Trigger architecture.

---

## 🏗️ Salesforce Objects Used

### Application Object

**Object API Name:**
`Application__c`

Important fields:

| Field | API Name | Type |
|---|---|---|
| Application Name | `Name` | Text |
| Job Opening | `Job_Opening__c` | Master-Detail |
| Status | `Status__c` | Picklist |
| Student | `Student__c` | Master-Detail |

### Student Object

**Object API Name:**
`Students__c`

Important fields:

| Field | API Name | Type |
|---|---|---|
| Student Name | `Name` | Text |
| Branch | `Branch__c` | Picklist |
| CGPA | `CGPA__c` | Number |
| Backlogs | `Backlogs__c` | Number |

---

## 🔄 Business Requirement

Whenever a new Application is created, Salesforce should automatically check the student's CGPA.

### Business Rule

```text
CGPA >= 6.0
    ↓
Application is allowed

CGPA < 6.0
    ↓
Application is rejected
