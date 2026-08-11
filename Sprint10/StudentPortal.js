import { LightningElement, wire } from 'lwc';
import getJobs from '@salesforce/apex/JobController.getJobs';

export default class StudentPortal extends LightningElement {

    jobs = [];
    error;
    selectedJobId;
    applicationJobId;

    @wire(getJobs)
    wiredJobs({ data, error }) {

        if (data) {
            this.jobs = data;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.jobs = [];
        }
    }

    handleViewDetails(event) {

        const jobId = event.detail.jobId;

        console.log('View Details clicked for Job:', jobId);

        this.selectedJobId = jobId;
    }

    handleApply(event) {

        const jobId = event.detail.jobId;

        console.log('Apply clicked for Job:', jobId);

        this.applicationJobId = jobId;
    }
}
