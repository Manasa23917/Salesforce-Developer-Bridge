public with sharing class JobController {

    @AuraEnabled(cacheable=true)
    public static List<Job__c> getJobs() {

        return [
            SELECT Id,
                   Name,
                   CompanyName__c,
                   ClosingDate__c,
                   JobStatus__c,
                   Minimum_CGPA__c
            FROM Job__c
            ORDER BY ClosingDate__c ASC
        ];
    }
}
