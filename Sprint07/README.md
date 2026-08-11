# Sprint 7 – Bulk Processing and Governor Limits

## Objective

This sprint focuses on writing scalable Apex code that can process multiple records efficiently while following Salesforce Governor Limits and Bulkification best practices.

---

## Learning Outcomes

During this sprint, I learned:

- Understanding Salesforce Governor Limits
- Importance of writing scalable Apex code
- Difference between record processing and bulk processing
- SOQL Governor Limits
- DML Governor Limits
- Why SOQL should not be used inside loops
- Why DML should not be used inside loops
- Bulkification in Apex
- Using List, Set and Map collections
- Bulk-safe Trigger development
- Trigger Context Variables
- Collection-based processing
- Engineering best practices for Apex development

---

## Governor Limits Covered

- SOQL Queries
- DML Statements
- Records Retrieved
- Records Processed
- CPU Time
- Heap Size

---

## Important Concepts

### SOQL Inside Loop (Bad Practice)

Running SOQL inside a loop causes one query for every record.

Example:

```apex
for(Application__c app : Trigger.new){

    Student__c student = [
        SELECT Id, Name
        FROM Student__c
        WHERE Id=:app.Student__c
    ];

}
```

Problem:

- Executes multiple SOQL queries
- May exceed Governor Limits
- Poor performance

---

### Correct Bulkified Approach

Collect Student Ids first.

```apex
Set<Id> studentIds = new Set<Id>();

for(Application__c app : Trigger.new){

    if(app.Student__c != null){

        studentIds.add(app.Student__c);

    }

}
```

Query only once.

```apex
Map<Id, Student__c> studentMap =
new Map<Id, Student__c>(

    [
        SELECT Id,
               Name,
               CGPA__c,
               Backlogs__c
        FROM Student__c
        WHERE Id IN :studentIds
    ]

);
```

---

## DML Inside Loop (Bad Practice)

```apex
for(Application__c app : Trigger.new){

    update app;

}
```

Problem:

- Multiple DML Statements
- Governor Limit Exception
- Poor Performance

---

## Correct DML Approach

```apex
List<Application__c> applicationsToUpdate =
new List<Application__c>();

for(Application__c app : Trigger.new){

    app.Status__c='Validated';

    applicationsToUpdate.add(app);

}

if(!applicationsToUpdate.isEmpty()){

    update applicationsToUpdate;

}
```

---

## Collections Used

### List

Used to store multiple records.

Example

```apex
List<Application__c> applications;
```

---

### Set

Used to store unique values.

Example

```apex
Set<Id> studentIds = new Set<Id>();
```

---

### Map

Used for fast record lookup.

Example

```apex
Map<Id, Student__c> studentMap;
```

---

## Bulk Processing Pattern

Receive Records

↓

Collect Ids

↓

One SOQL Query

↓

Store in Map

↓

Process Records

↓

Collect Updates

↓

One DML Operation

---

## Trigger Context Variables

- Trigger.new
- Trigger.old
- Trigger.newMap
- Trigger.oldMap

---

## Trigger

```apex
trigger ApplicationTrigger
on Application__c (before insert) {

    ApplicationService.validateApplications(
        Trigger.new
    );

}
```

---

## Service Class

```apex
public class ApplicationService {

    public static void validateApplications(
        List<Application__c> applications
    ){

        Set<Id> studentIds = new Set<Id>();

        for(Application__c app : applications){

            if(app.Student__c != null){

                studentIds.add(app.Student__c);

            }

        }

        Map<Id, Student__c> studentMap =
        new Map<Id, Student__c>(

            [
                SELECT Id,
                       Name,
                       CGPA__c,
                       Backlogs__c
                FROM Student__c
                WHERE Id IN :studentIds
            ]

        );

        for(Application__c app : applications){

            Student__c student =
            studentMap.get(app.Student__c);

            if(student == null){

                continue;

            }

            if(student.CGPA__c < 7){

                app.addError(
                    'CGPA should be at least 7'
                );

            }

            if(student.Backlogs__c > 0){

                app.addError(
                    'Student has active backlogs.'
                );

            }

        }

    }

}
```

---

## Best Practices Followed

- Bulkified Apex
- One SOQL Query
- One DML Statement
- Used List, Set and Map
- No SOQL inside loops
- No DML inside loops
- Collection-based processing
- Trigger Handler Pattern
- Governor Limit Safe Code

---

## Interview Questions Practiced

- What are Governor Limits?
- What is Bulkification?
- Why avoid SOQL inside loops?
- Why avoid DML inside loops?
- Difference between List, Set and Map
- Trigger.new vs Trigger.old
- Trigger.newMap vs Trigger.oldMap
- Explain Multi-Tenant Architecture
- Explain Bulk Processing Pattern

---

## Skills Gained

- Apex Programming
- Bulk Processing
- Governor Limits
- Trigger Development
- Collections in Apex
- Performance Optimization
- Salesforce Best Practices
- Enterprise Apex Design

---

## Conclusion

Successfully understood and implemented Salesforce Bulk Processing concepts using Governor Limits, Lists, Sets, Maps, Trigger Context Variables and Bulkification techniques. The implementation follows Salesforce best practices for scalable and efficient Apex development.
