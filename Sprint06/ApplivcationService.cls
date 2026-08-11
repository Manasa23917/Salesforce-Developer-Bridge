public class ApplicationService {

    public static void validateApplications(
        List<Application__c> applications
    ) {

        Set<Id> studentIds = new Set<Id>();

        for (Application__c app : applications) {
            if (app.Student__c != null) {
                studentIds.add(app.Student__c);
            }
        }

        Map<Id, Students__c> students = new Map<Id, Students__c>(
            [
                SELECT Id, Name, CGPA__c
                FROM Students__c
                WHERE Id IN :studentIds
            ]
        );

        for (Application__c app : applications) {

            if (app.Student__c == null) {
                app.addError('Student is required.');
                continue;
            }

            Students__c student = students.get(app.Student__c);

            if (student == null) {
                app.addError('Student record could not be found.');
                continue;
            }

            if (student.CGPA__c == null || student.CGPA__c < 6.0) {
                app.addError(
                    'Application rejected. Student CGPA must be 6.0 or above.'
                );
            }
        }
    }
}
