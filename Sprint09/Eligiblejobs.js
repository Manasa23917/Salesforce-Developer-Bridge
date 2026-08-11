import { LightningElement, wire } from 'lwc';

import getPositions
    from '@salesforce/apex/PositionController.getPositions';

export default class EligibleJobs extends LightningElement {

    jobs = [];
    error;

    @wire(getPositions)
    wiredPositions({ data, error }) {

        if (data) {

            this.jobs = data.map(position => {

                return {
                    id: position.Id,
                    companyName: position.Name,
                    jobRole: position.Name
                };

            });

            this.error = undefined;

        } else if (error) {

            this.jobs = [];
            this.error = error;

            console.error('Error loading positions:', error);
        }
    }
}
