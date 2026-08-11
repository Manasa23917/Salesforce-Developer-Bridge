## 🏗️ Architecture

This project implements a **Salesforce-to-REST-API integration** using **Queueable Apex**, **HTTP Callouts**, **Named Credentials**, **External Credentials**, and an **External Credential Principal**.

The integration is designed to allow Salesforce to communicate with an external REST API asynchronously while keeping the endpoint and credential configuration separate from the Apex code.

### ⚡ Queueable Apex

The `CandidateSyncQueueable` class is the main component responsible for performing the API integration asynchronously.

It implements both `Queueable` and `Database.AllowsCallouts`, which allows Salesforce to execute the integration as a background job and perform an HTTP callout.

The Queueable class is responsible for:

- Creating the HTTP request.
- Setting the API endpoint.
- Using the GET HTTP method.
- Sending the request to the external API.
- Receiving the API response.
- Logging the response status code.
- Logging the response body.

The Queueable job can be started using:

```apex
System.enqueueJob(new CandidateSyncQueueable());
```

### 📡 HTTP Callout

The integration uses an HTTP GET request to communicate with the external REST API.

The request is created using the `HttpRequest` class:

```apex
HttpRequest request = new HttpRequest();

request.setEndpoint('callout:Candidate_API/posts');
request.setMethod('GET');
```

The request is then sent using the `Http` class:

```apex
Http http = new Http();
HttpResponse response = http.send(request);
```

The endpoint uses the Salesforce Named Credential reference:

```text
callout:Candidate_API/posts
```

Here, `Candidate_API` represents the Named Credential and `/posts` represents the API resource being requested.

Using this approach avoids placing the complete external API URL directly inside the Apex integration logic.

### 🔗 Named Credential

The Named Credential configured for this integration is:

| Property | Value |
|---|---|
| Label | Candidate API |
| Developer Name | `Candidate_API` |
| Base URL | `https://jsonplaceholder.typicode.com` |

The Named Credential provides the connection configuration for the external REST API.

The Apex code references the Named Credential instead of directly specifying the complete API URL:

```apex
request.setEndpoint('callout:Candidate_API/posts');
```

This separates the Apex logic from the external service configuration and makes the integration easier to maintain.

### 🔐 External Credential

The Named Credential is associated with the following External Credential:

```text
Candidate_API_External_Credential
```

The External Credential manages the credential and authentication configuration used by Salesforce for the external service.

For this project, the authentication protocol is configured as:

```text
No Authentication
```

This is because the JSONPlaceholder API used in this project is a public mock REST API and does not require authentication.

The configuration is:

```text
Named Credential
Candidate_API
        ↓
External Credential
Candidate_API_External_Credential
```

### 👤 External Credential Principal

The configured External Credential Principal is:

```text
CandidateAPIPrincipal
```

The principal is associated with the External Credential and forms part of Salesforce's credential access model.

The configured relationship is:

```text
Candidate_API
        ↓
Candidate_API_External_Credential
        ↓
CandidateAPIPrincipal
```

The External Credential Principal was successfully configured as part of the integration setup.

### 🔑 Permission and Access

The Salesforce user executing the Queueable Apex must have the required access to the External Credential Principal.

Salesforce checks the user's access before allowing the credential to be used for the callout.

Proper permission configuration is important because Salesforce can return a credential-access error even when the Named Credential and External Credential already exist.

The required principal access was configured and verified for this integration.

### 🌐 External REST API

The external service used in this project is **JSONPlaceholder**, a public mock REST API used for testing and demonstrating REST API integrations.

The base API URL is:

```text
https://jsonplaceholder.typicode.com
```

The endpoint used by the Queueable is:

```text
https://jsonplaceholder.typicode.com/posts
```

The integration sends an HTTP `GET` request to the `/posts` resource and receives JSON data as the response.

### 📥 API Response

After the external API processes the request, Salesforce receives the result through the `HttpResponse` object.

The response contains:

- HTTP status code
- Response status
- Response body

The response can be verified using Apex debug logs:

```apex
System.debug('Status Code: ' + response.getStatusCode());
System.debug('Response Body: ' + response.getBody());
```

A successful API request returns an HTTP success status such as:

```text
200 OK
```

The response body contains JSON data returned by the external API.

### 🔄 Complete Integration Process

The complete process implemented in this project is:

1. The Salesforce user starts the `CandidateSyncQueueable` job.
2. Salesforce places the Queueable job into asynchronous processing.
3. Salesforce executes the Queueable class.
4. The Queueable creates an `HttpRequest`.
5. The HTTP method is set to `GET`.
6. The endpoint is specified using `callout:Candidate_API/posts`.
7. Salesforce resolves the `Candidate_API` Named Credential.
8. The Named Credential uses `Candidate_API_External_Credential`.
9. Salesforce resolves the `CandidateAPIPrincipal`.
10. Salesforce verifies the required user access.
11. Salesforce sends the HTTP GET request to JSONPlaceholder.
12. JSONPlaceholder processes the request.
13. The external API returns a JSON response.
14. Salesforce receives the response in the `HttpResponse` object.
15. The response status code and body are written to the debug log.
16. The Queueable job completes.


### 🎯 Architecture Benefits

This architecture provides several benefits:

- ⚡ **Asynchronous Processing** — Queueable Apex allows the API integration to execute in the background.
- 🔗 **Centralized Configuration** — Named Credentials keep the external endpoint configuration outside the Apex logic.
- 🔐 **Credential Management** — External Credentials provide Salesforce's modern credential management framework.
- 👤 **Controlled Access** — External Credential Principals and permissions control access to the configured credentials.
- 📡 **REST API Integration** — Salesforce can communicate with external services using HTTP callouts.
- 🛡️ **Separation of Responsibilities** — Apex code, endpoint configuration, credentials, and access management are handled separately.
- 🛠️ **Easy Troubleshooting** — HTTP status codes and response bodies can be inspected using debug logs.
- 📈 **Maintainable Design** — The same architecture can be reused for other external REST API integrations.

### 🧪 Testing and Verification

The integration was tested by executing the Queueable Apex job and monitoring the asynchronous Apex execution.

The following areas were verified:

- Queueable Apex class deployment.
- Named Credential configuration.
- External Credential configuration.
- External Credential Principal configuration.
- Principal access and permissions.
- HTTP callout execution.
- External API response.
- HTTP status code.
- Response body.
- Queueable job completion.

The API response can be verified through Salesforce Debug Logs using:

```apex
System.debug('Status Code: ' + response.getStatusCode());
System.debug('Response Body: ' + response.getBody());
```

A successful execution confirms that Salesforce can communicate with the configured external REST API.

### 🏁 Final Outcome

The completed project demonstrates a complete Salesforce REST API integration using:

**Queueable Apex → HTTP Callout → Named Credential → External Credential → External Credential Principal → Permission Access → REST API → JSON Response**

The implementation demonstrates how Salesforce can asynchronously communicate with an external REST API while keeping connection configuration and credential management outside the Apex business logic.

This provides a clean, secure, maintainable, and reusable foundation for building Salesforce integrations with external services.
