public class CandidateSyncQueueable implements Queueable, Database.AllowsCallouts {

    private Id applicationId;

    public CandidateSyncQueueable(Id applicationId) {
        this.applicationId = applicationId;
    }

    public void execute(QueueableContext context) {

        Application__c applicationRecord = [
            SELECT Id, Status__c
            FROM Application__c
            WHERE Id = :applicationId
            LIMIT 1
        ];

        // Prepare integration information in memory.
        // DO NOT perform DML before the callout.
        applicationRecord.put(
            'Not_Sent_Pending_Success_Failure_Retry_R__c',
            'Pending'
        );

        applicationRecord.put(
            'Last_Integration_Attempt__c',
            System.now()
        );

        applicationRecord.put(
            'Integration_Error__c',
            null
        );

        try {

            // Prepare JSON payload
            Map<String, Object> payload = new Map<String, Object>();

            payload.put('applicationId', applicationRecord.Id);
            payload.put('status', applicationRecord.Status__c);
            payload.put(
                'source',
                'Salesforce Placement Management System'
            );

            String requestBody = JSON.serialize(payload);

            // Create HTTP request
            HttpRequest request = new HttpRequest();

            request.setEndpoint('callout:Candidate_API/posts');
            request.setMethod('POST');
            request.setHeader('Content-Type', 'application/json');
            request.setBody(requestBody);
            request.setTimeout(10000);

            // Perform callout BEFORE any DML
            Http http = new Http();
            HttpResponse response = http.send(request);

            Integer statusCode = response.getStatusCode();

            // SUCCESS
            if (statusCode == 200 || statusCode == 201) {

                Map<String, Object> responseData =
                    (Map<String, Object>) JSON.deserializeUntyped(
                        response.getBody()
                    );

                applicationRecord.put(
                    'Not_Sent_Pending_Success_Failure_Retry_R__c',
                    'Success'
                );

                if (responseData.containsKey('id')) {
                    applicationRecord.put(
                        'External_Candidate_Id__c',
                        String.valueOf(responseData.get('id'))
                    );
                }

                applicationRecord.put(
                    'Integration_Error__c',
                    null
                );
            }

            // BAD REQUEST
            else if (statusCode == 400) {

                applicationRecord.put(
                    'Not_Sent_Pending_Success_Failure_Retry_R__c',
                    'Failure'
                );

                applicationRecord.put(
                    'Integration_Error__c',
                    'HTTP 400 - Bad Request: ' +
                    response.getBody()
                );
            }

            // UNAUTHORIZED
            else if (statusCode == 401) {

                applicationRecord.put(
                    'Not_Sent_Pending_Success_Failure_Retry_R__c',
                    'Failure'
                );

                applicationRecord.put(
                    'Integration_Error__c',
                    'HTTP 401 - Unauthorized'
                );
            }

            // FORBIDDEN
            else if (statusCode == 403) {

                applicationRecord.put(
                    'Not_Sent_Pending_Success_Failure_Retry_R__c',
                    'Failure'
                );

                applicationRecord.put(
                    'Integration_Error__c',
                    'HTTP 403 - Forbidden'
                );
            }

            // SERVER ERROR
            else if (statusCode == 500 || statusCode == 503) {

                applicationRecord.put(
                    'Not_Sent_Pending_Success_Failure_Retry_R__c',
                    'Retry Required'
                );

                applicationRecord.put(
                    'Integration_Error__c',
                    'HTTP ' + statusCode +
                    ' - External server temporarily unavailable'
                );
            }

            // UNEXPECTED STATUS
            else {

                applicationRecord.put(
                    'Not_Sent_Pending_Success_Failure_Retry_R__c',
                    'Failure'
                );

                applicationRecord.put(
                    'Integration_Error__c',
                    'Unexpected HTTP ' + statusCode +
                    ': ' + response.getBody()
                );
            }

            // DML happens AFTER the callout
            update applicationRecord;

        } catch (Exception e) {

            applicationRecord.put(
                'Not_Sent_Pending_Success_Failure_Retry_R__c',
                'Retry Required'
            );

            applicationRecord.put(
                'Integration_Error__c',
                'Exception: ' + e.getMessage()
            );

            // Safe here because no further callout is being made
            update applicationRecord;
        }
    }
}
