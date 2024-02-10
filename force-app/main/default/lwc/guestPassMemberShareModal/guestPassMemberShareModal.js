import { api } from 'lwc';
import LightningModal from 'lightning/modal';
import sendGuestPass from '@salesforce/apex/GuestPassController.sendGuestPass';

export default class GuestPassMemberShareModal extends LightningModal {
    @api guestPass;
    isLoading = false;
    error;

    firstName;
    lastName;
    email;

    get modalHeader() {
        return `Share ${this.guestPass.passNumber}`;
    }

    handleFirstNameChange(event) {
        this.firstName = event.detail.value;
    }

    handleLastNameChange(event) {
        this.lastName = event.detail.value;
    }

    handleEmailChange(event) {
        this.email = event.detail.value;
    }

    handleSubmit() {
        this.isLoading = true;

        const allValid = [...this.template.querySelectorAll('lightning-input')]
            .reduce((validSoFar, inputFields) => {
                inputFields.reportValidity();
                return validSoFar && inputFields.checkValidity();
            }, true);
        
        if (allValid) {
            sendGuestPass({
                guestPassId: this.guestPass.id,
                firstName: this.firstName,
                lastName: this.lastName,
                email: this.email 
            }).then((result) => {
                this.isLoading = false;
                this.close(this.firstName);
            }).catch((error) => {
                this.error = error;
                console.error(this.error);
                this.isLoading = false;
                this.close('error');
            });
        }
    }
    
}