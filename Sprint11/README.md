## 🏗️ Architecture

This project implements a **Salesforce-to-REST-API integration** using **Queueable Apex**, **HTTP Callouts**, **Named Credentials**, **External Credentials**, and an **External Credential Principal**.

The integration is designed to allow Salesforce to communicate with an external REST API asynchronously while keeping the endpoint and credential configuration separate from the Apex code.

### ⚡ Queueable Apex

The `CandidateSyncQueueable` class is responsible for performing the integration asynchronously.

It implements `Queueable` and `Database.AllowsCallouts`, allowing Salesforce to execute the API request as a background job.

The Queueable class:

- Creates the HTTP request.
- Sets the API endpoint.
- Uses the GET HTTP method.
- Sends the request to the external API.
- Receives the API response.
- Logs the status code and response body.

The job can be started using:

```apex
System.enqueueJob(new CandidateSyncQueueable());
📡 HTTP Callout

The integration uses an HTTP GET request to communicate with the external REST API.

The endpoint is referenced in Apex using the Named Credential:

request.setEndpoint('callout:Candidate_API/posts');

This approach avoids placing the complete external API URL directly inside the Apex code.

🔗 Named Credential

The Named Credential used in this project is:

Label: Candidate API
Developer Name: Candidate_API
Base URL: https://jsonplaceholder.typicode.com

The Named Credential provides the connection configuration for the external API.

Using a Named Credential keeps the endpoint configuration separate from the Apex logic and makes the integration easier to maintain.

🔐 External Credential

The Named Credential is associated with:

Candidate_API_External_Credential

The External Credential manages the credential and authentication configuration used by Salesforce.

For this project, the authentication protocol is configured as:

No Authentication

This is because the JSONPlaceholder API used for testing does not require authentication.

👤 External Credential Principal

The configured External Credential Principal is:

CandidateAPIPrincipal

The principal is associated with the External Credential and forms part of Salesforce's credential access model.

The principal was configured successfully as part of the integration setup.

🔑 Permission and Access

The Salesforce user executing the Queueable Apex must have the required access to the configured External Credential Principal.

Proper permission configuration is important because Salesforce may prevent the callout if the user does not have access to the credential, even when the Named Credential and External Credential are correctly configured.

🌐 External REST API

The external API used for this project is JSONPlaceholder, a public mock REST API commonly used for testing and demonstrating API integrations.

The endpoint used is:

https://jsonplaceholder.typicode.com/posts

The Queueable sends a GET request to this endpoint and receives JSON data as the response.

📥 API Response

The response from the external API is received through the Salesforce HttpResponse object.

The response contains:

HTTP status code
Response status
Response body

The response can be verified using:

System.debug('Status Code: ' + response.getStatusCode());
System.debug('Response Body: ' + response.getBody());

A successful API request returns a success status such as:

200 OK

along with the JSON response body.
