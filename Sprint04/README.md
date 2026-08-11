# Salesforce Placement Portal – LWC

## Project Overview

This project was created as part of the Salesforce Interview Readiness Bootcamp – Day 4.

The objective of this project was to learn the basics of Lightning Web Components (LWC) and build a simple user interface for a Placement Management System.

## What is LWC?

Lightning Web Components (LWC) is Salesforce's modern framework for building user interfaces using web standards such as HTML, JavaScript, and CSS.

LWC allows developers to create reusable, fast, and maintainable components that can interact with Salesforce data.

## What Did I Build?

I built a simple **Placement Portal Home Page** using LWC.

The component displays:

- Student Name
- Roll Number
- Department
- Number of Companies
- Number of Jobs
- Applications Submitted
- Application Status

The component also includes interactive buttons:

- Show Welcome Message
- Apply Now

The application status changes from:

`Not Applied → Applied`

when the user clicks the Apply Now button.

The values are currently hard-coded. In future, Apex and SOQL can be used to retrieve real data from Salesforce.

## LWC Component Structure

The component is named:

`placementHome`

It contains three main files:

### 1. HTML File

File:

`placementHome.html`

The HTML file is responsible for the user interface and page structure.

It contains:

- Text
- Buttons
- Data binding
- UI elements

Example:

`{studentName}`

### 2. JavaScript File

File:

`placementHome.js`

The JavaScript file contains the component's logic.

It contains:

- Variables
- Functions
- Button click events
- Data changes

For example:

`showWelcomeMessage()`

and

`applyForJob()`

### 3. Meta XML File

File:

`placementHome.js-meta.xml`

The metadata file controls where the component can be used in Salesforce.

The component was exposed to the Lightning App Builder using:

`lightning__AppPage`

## What Did I Learn Today?

During Day 4, I learned:

- What Lightning Web Components are
- Structure of an LWC
- HTML, JavaScript, and Meta XML files
- Creating and deploying an LWC
- Data binding using `{propertyName}`
- Creating JavaScript variables
- Handling button click events
- Updating UI values using JavaScript
- Deploying an LWC to a Lightning App Page
- Understanding the relationship between UI and JavaScript

## Technologies Used

- Salesforce
- Lightning Web Components (LWC)
- HTML
- JavaScript
- Salesforce CLI
- Visual Studio Code

## Future Enhancement

In the next stage, the hard-coded placement statistics can be connected to Salesforce data using:

- Apex
- SOQL
- Salesforce Custom Objects

This will allow the Placement Portal to display real-time data from the Salesforce database.

## Project Outcome

Successfully created and deployed a Lightning Web Component for a Placement Management System and learned the fundamentals of Salesforce front-end development.

##Screenshots
<img width="1436" height="908" alt="image" src="https://github.com/user-attachments/assets/8020d65e-4138-49d2-a4f4-d7ecbb73e17b" />
---
<img width="557" height="431" alt="image" src="https://github.com/user-attachments/assets/58c76c58-a829-4185-ba9b-9b0280d94668" />
---
<img width="476" height="340" alt="image" src="https://github.com/user-attachments/assets/942b5048-d086-4dea-b915-57338263f305" />
---
<img width="471" height="551" alt="image" src="https://github.com/user-attachments/assets/6fdeb87f-c1e7-4091-8284-89715e2542b9" />
---
<img width="392" height="438" alt="image" src="https://github.com/user-attachments/assets/d063663f-77f3-48fe-ab1f-ed7242ab717e" />
---
<img width="871" height="666" alt="image" src="https://github.com/user-attachments/assets/e9e9bb9e-ad5f-462e-9349-5701dc2b96bf" />
