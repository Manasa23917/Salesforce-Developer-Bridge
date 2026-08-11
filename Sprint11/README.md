Salesforce Candidate API Integration
📌 Project Overview

This project demonstrates how to integrate Salesforce with an external REST API using Queueable Apex, Named Credentials, External Credentials, and Principals.

The integration sends an HTTP request from Salesforce to an external Candidate API and processes the API response asynchronously.

The implementation follows Salesforce's recommended approach of using a Named Credential instead of hard-coding authentication or endpoint configuration directly inside Apex.

🎯 Objectives

The main objectives of this task were to:

Create a Queueable Apex class for asynchronous API communication.
Configure a Salesforce Named Credential.
Configure an External Credential.
Create and configure an External Credential Principal.
Grant the required permission to access the principal.
Perform an HTTP callout from Queueable Apex.
Deploy the Apex class using Salesforce CLI.
Execute the Queueable Apex job.
Verify that the external API call works successfully.
🏗️ Integration Architecture
                    Salesforce
                        │
                        ▼
              CandidateSyncQueueable
                    Queueable Apex
                        │
                        │ HTTP Callout
                        ▼
                Named Credential
                  Candidate_API
                        │
                        ▼
                External Credential
             Candidate_API_External_Credential
                        │
                        ▼
                Principal
             CandidateAPIPrincipal
                        │
                        ▼
              External REST API
        https://jsonplaceholder.typicode.com
🔧 Technologies Used
Technology	Purpose
Salesforce	CRM and development platform
Apex	Server-side Salesforce programming
Queueable Apex	Asynchronous processing
REST API	External system communication
Named Credential	Secure endpoint configuration
External Credential	Authentication/credential configuration
Principal	Access to the external credential
Salesforce CLI	Deployment and querying
JSONPlaceholder	Mock REST API
VS Code	Salesforce development
📂 Project Structure
force-app/
└── main/
    └── default/
        └── classes/
            ├── CandidateSyncQueueable.cls
            └── CandidateSyncQueueable.cls-meta.xml
1️⃣ Create the Queueable Apex Class

The main Apex class used for the integration is:

CandidateSyncQueueable.cls

The class implements:

Queueable

and performs an HTTP callout using:

Database.AllowsCallouts

A typical structure is:

public class CandidateSyncQueueable implements Queueable, Database.AllowsCallouts {

    public void execute(QueueableContext context) {

        HttpRequest request = new HttpRequest();

        request.setEndpoint('callout:Candidate_API/posts');
        request.setMethod('GET');

        Http http = new Http();

        HttpResponse response = http.send(request);

        System.debug('Status Code: ' + response.getStatusCode());
        System.debug('Response Body: ' + response.getBody());
    }
}
Important

The endpoint is:

callout:Candidate_API/posts

Instead of directly writing:

https://jsonplaceholder.typicode.com/posts

This allows Salesforce to resolve the endpoint through the Named Credential.

2️⃣ Why Queueable Apex?

Queueable Apex allows Salesforce to execute processing asynchronously.

Instead of making the user wait for the external API request, Salesforce places the job into the asynchronous Apex queue.

Benefits
Supports asynchronous processing.
Can perform HTTP callouts.
Better structure than traditional future methods.
Supports more complex processing.
Can be monitored using Salesforce's Apex Jobs.
Can be chained with other Queueable jobs when required.
3️⃣ Create the Named Credential

Navigate to:

Setup
   ↓
Named Credentials
   ↓
Candidate API

The Named Credential was configured as:

Label:
Candidate API

Developer Name:
Candidate_API

The endpoint is:

https://jsonplaceholder.typicode.com
4️⃣ Configure External Credential

The Named Credential uses the following External Credential:

Candidate_API_External_Credential

The External Credential defines the credential/authentication configuration used by Salesforce.

In this project, the API uses:

Authentication Protocol:
No Authentication

This is suitable for the JSONPlaceholder mock API because it does not require authentication.

5️⃣ Configure the Principal

The External Credential contains the following principal:

CandidateAPIPrincipal

The principal represents the identity/access configuration associated with the External Credential.

The final configuration was:

External Credential
        │
        ▼
Candidate_API_External_Credential
        │
        ▼
CandidateAPIPrincipal
        │
        ▼
Configured
6️⃣ Configure Permission Access

The running Salesforce user must have permission to use the External Credential principal.

The permission configuration allows the Queueable Apex execution to access:

CandidateAPIPrincipal

Without this permission, Salesforce can produce an error similar to:

We couldn't access the credential(s).
You might not have the required permissions...

Therefore, configuring the principal alone is not enough.

The user must also have the required access.

7️⃣ Verify Named Credential

The Named Credential was verified using Salesforce CLI.

Command:

sf data query --query "SELECT Id, DeveloperName, MasterLabel FROM NamedCredential" --target-org WiseMoose

The expected result included:

DeveloperName
Candidate_API

and:

MasterLabel
Candidate API

This confirmed that the Named Credential existed in the target org.

8️⃣ Deploy the Queueable Apex

The Apex class was deployed using Salesforce CLI.

Command:

sf project deploy start --source-dir force-app/main/default/classes/CandidateSyncQueueable.cls --target-org WiseMoose

A successful deployment confirms that Salesforce accepted the Apex metadata.

9️⃣ Execute the Queueable Apex

The Queueable job can be executed through:

System.enqueueJob(new CandidateSyncQueueable());

For example, this can be executed through:

Developer Console
Anonymous Apex

or the appropriate Salesforce development environment.

🔟 Monitor the Apex Job

After enqueueing the Queueable job, Salesforce creates an asynchronous Apex job.

Navigate to:

Setup
   ↓
Apex Jobs

Find:

CandidateSyncQueueable

The job should have:

Status: Completed

A successful execution indicates that Salesforce was able to process the Queueable job and perform the callout.

1️⃣1️⃣ API Endpoint

The external API used for this hands-on task is:

https://jsonplaceholder.typicode.com/posts

JSONPlaceholder is a public mock REST API useful for testing integrations.

The Salesforce request is constructed as:

request.setEndpoint('callout:Candidate_API/posts');

Salesforce combines:

Candidate_API

with:

/posts

to resolve the external endpoint.

1️⃣2️⃣ HTTP Request

The request uses:

Method: GET

Example:

HttpRequest request = new HttpRequest();

request.setEndpoint('callout:Candidate_API/posts');
request.setMethod('GET');

Then:

Http http = new Http();

HttpResponse response = http.send(request);
1️⃣3️⃣ Verify the Response

The response can be inspected using:

System.debug('Status Code: ' + response.getStatusCode());
System.debug('Response Body: ' + response.getBody());

A successful HTTP request should return an HTTP success status such as:

200

The response body contains JSON data representing posts from the mock API.

Example structure:

[
  {
    "userId": 1,
    "id": 1,
    "title": "sample title",
    "body": "sample body"
  }
]
🔐 Why Named Credentials?

Instead of hard-coding:

request.setEndpoint(
    'https://jsonplaceholder.typicode.com/posts'
);

we use:

request.setEndpoint(
    'callout:Candidate_API/posts'
);
Advantages
Centralized endpoint configuration.
Better security.
Easier environment configuration.
Avoids hard-coding endpoint details.
Simplifies authentication management.
Recommended Salesforce integration pattern.
🔄 Complete Execution Flow
1. User/System starts Queueable Apex
              ↓
2. CandidateSyncQueueable is enqueued
              ↓
3. Salesforce executes Queueable asynchronously
              ↓
4. Apex creates HttpRequest
              ↓
5. Endpoint:
   callout:Candidate_API/posts
              ↓
6. Salesforce resolves Named Credential
              ↓
7. Named Credential uses:
   Candidate_API_External_Credential
              ↓
8. Principal:
   CandidateAPIPrincipal
              ↓
9. Permission is checked
              ↓
10. HTTP GET request sent
              ↓
11. JSONPlaceholder API responds
              ↓
12. Salesforce receives HTTP response
              ↓
13. Response status/body logged
              ↓
14. Queueable job completes
