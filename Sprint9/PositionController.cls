public with sharing class PositionController {

    @AuraEnabled(cacheable=true)
    public static List<Position__c> getPositions() {

        return [
            SELECT Id, Name
            FROM Position__c
            ORDER BY Name
        ];
    }
}
