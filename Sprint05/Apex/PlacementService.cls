public class PlacementApplicationService {

    public static String submitApplication(Id studentId, Id jobId) {

        // 1. Retrieve Student
        List<Students__c> students = [
            SELECT Id, Name, CGPA__c, Branch__c, Backlogs__c
            FROM Students__c
            WHERE Id = :studentId
            LIMIT 1
        ];

        if (students.isEmpty()) {
            return 'Student not found.';
        }

        Students__c student = students[0];

        // 2. Retrieve Job Opening
        List<Job_Opening__c> jobs = [
            SELECT Id, Name, Minimum_CGPA__c,
                   Eligible_Branches__c,
                   Maximum_Backlogs__c
            FROM Job_Opening__c
            WHERE Id = :jobId
            LIMIT 1
        ];

        if (jobs.isEmpty()) {
            return 'Job Opening not found.';
        }

        Job_Opening__c job = jobs[0];

        // 3. Check Duplicate Application
        List<Application__c> existingApplications = [
            SELECT Id, Name, Status__c
            FROM Application__c
            WHERE Student__c = :studentId
            AND Job_Opening__c = :jobId
            LIMIT 1
        ];

        if (!existingApplications.isEmpty()) {
            return 'You have already applied for this job.';
        }

        // 4. Validate CGPA
        if (student.CGPA__c == null ||
            job.Minimum_CGPA__c == null ||
            student.CGPA__c < job.Minimum_CGPA__c) {

            return 'CGPA requirement not satisfied.';
        }

        // 5. Validate Branch
        if (student.Branch__c == null ||
            job.Eligible_Branches__c == null ||
            !job.Eligible_Branches__c.contains(student.Branch__c)) {

            return 'Your branch is not eligible for this job.';
        }

        // 6. Validate Backlogs
        if (student.Backlogs__c == null ||
            job.Maximum_Backlogs__c == null ||
            student.Backlogs__c > job.Maximum_Backlogs__c) {

            return 'Backlog requirement not satisfied.';
        }

        // 7. Create Application
        Application__c application = new Application__c();

        application.Name = student.Name + ' - ' + job.Name;
        application.Student__c = student.Id;
        application.Job_Opening__c = job.Id;
        application.Status__c = 'Applied';

        // 8. Save Application
        insert application;

        // 9. Return Confirmation
        return 'Application submitted successfully. Application Id: '
            + application.Id;
    }
}
