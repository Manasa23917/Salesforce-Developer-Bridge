# Chapter 5 – SOQL, DML & Apex: Complete Business Transactions

## Salesforce Placement Management System

### Overview

In this chapter, I implemented a complete business transaction for a Salesforce Placement Management System using **Apex, SOQL, and DML**.

The system allows a student to apply for a job opening after checking the required business rules.

### Business Flow

Student clicks Apply

↓

Retrieve Student Details

↓

Retrieve Job Eligibility

↓

Check Duplicate Application

↓

Validate Eligibility

↓

Create Application

↓

Save Application

↓

Return Result

---

## Technologies Used

- Salesforce
- Apex
- SOQL
- DML
- Developer Console
- Execute Anonymous

---

## Salesforce Objects Used

### Students__c

Stores student information.

Important fields:

- `Id`
- `Name`
- `CGPA__c`
- `Branch__c`
- `Backlogs__c`

### Job_Opening__c

Stores job opening and eligibility criteria.

Important fields:

- `Id`
- `Name`
- `Minimum_CGPA__c`
- `Eligible_Branches__c`
- `Maximum_Backlogs__c`

### Application__c

Stores student applications.

Important fields:

- `Student__c`
- `Job_Opening__c`
- `Status__c`
- `Application_Date__c`

---

# SOQL Queries

## 1. Retrieve Student Details

```sql
SELECT Id, Name, CGPA__c, Branch__c, Backlogs__c
FROM Students__c
