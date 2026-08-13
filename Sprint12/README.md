# Sprint 12 – From Developer Org to Production

## Git, Salesforce CLI, Metadata, Sandboxes and Deployment

> Writing code is only part of development. A professional developer must also know how to manage, test, review and safely deliver that code.

---

## 📚 Overview

Sprint 12 focuses on taking a Salesforce application from a developer environment toward a controlled production-ready development and deployment process.

The main topics covered in this sprint are:

- Git and Version Control
- Git Branches and Pull Requests
- Salesforce CLI
- Salesforce Metadata
- Metadata Retrieval and Deployment
- Sandboxes
- Scratch Orgs
- Changesets
- Metadata API
- Deployment Dependencies
- Testing
- Git Conflict Resolution
- Deployment Pipelines
- Professional GitHub Repository Structure

---

# 1. Why Git Matters

A Salesforce application should not exist only inside a Salesforce Org.

When multiple developers work on the same project, Git helps answer questions such as:

- Who changed the code?
- Which version is correct?
- When was it changed?
- Why was it changed?
- Can the change be undone?
- Who introduced the problem?

Git provides a structured way to manage these changes.

### Engineering Principle

> **Your Org Is an Environment. Your Repository Is the Record of Development.**

A Salesforce Org contains metadata and data, while Git maintains the source representation and history of the development.

```text
Git Repository
      ↓
Source of Development
      ↓
Deployment
      ↓
Salesforce Org
