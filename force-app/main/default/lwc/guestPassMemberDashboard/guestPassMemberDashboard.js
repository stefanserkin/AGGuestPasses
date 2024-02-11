import { LightningElement, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';
import GuestFormModal from 'c/guestPassMemberShareModal';
import getHostGuestPasses from '@salesforce/apex/GuestPassController.getHostGuestPasses';
import USER_ID from '@salesforce/user/Id';
import ACCOUNTID_FIELD from '@salesforce/schema/User.AccountId';

export default class GuestPassMemberDashboard extends LightningElement {
    isLoading = false;
    isShareMode = false;
    error;
    accountId;
    wiredGuestPasses = [];
    guestPasses;

    cardTitle = 'Manage Guest Passes';
    cardIconName = 'action:add_contact';

    @wire(getRecord, {
		recordId: USER_ID,
		fields: [ACCOUNTID_FIELD]
	}) wireuser({
		error,
		data
	}) {
		if (error) {
			this.error = error; 
		} else if (data) {
			this.accountId = data.fields.AccountId.value;
		}
	}

    @wire(getHostGuestPasses, { 
        accountId: '$accountId' 
    }) wireResult(result) {
        this.isLoading = true;
        this.wiredGuestPasses = result;
        if (result.data) {
            let rows = JSON.parse( JSON.stringify(result.data) );
            rows.forEach(row => {
                if (row.guestFirstName != null) {
                    row.guestName = row.guestFirstName + ' ' + row.guestLastName;
                    row.guestInfo = 'Shared with ' + row.guestName + ' on ' + this.formatDateString(row.dateShared);
                }
            });
            this.guestPasses = rows;
            this.error = undefined;
            this.isLoading = false;
        } else if (result.error) {
            this.guestPasses = undefined;
            this.error = result.error;
            console.error(this.error);
            this.isLoading = false;
        }
    }

    async handleSharePass(event) {
        const selectedId = event.target.dataset.id;
        console.log(selectedId);
        const selectedPass = this.guestPasses.find(pass => {
            return pass.id === selectedId
        });
        const result = await GuestFormModal.open({
            size: 'small',
            description: 'Share guest pass with a guest',
            guestPass: selectedPass,
        });

        if (!result) return;

        if (result == 'error') {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'An Error Occurred',
                    message: `The guest pass could not be shared. Please contact support.`,
                    variant: 'error'
                })
            );
        } // Closed modals with successfully submitted forms will return the guest's first name
        else if (result.length > 0) {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Invitation Sent!',
                    message: `We sent ${result} an email with instructions on how to use the pass. Thanks for sharing Asphalt Green!`,
                    variant: 'success'
                })
            );
            this.refreshComponent();
        }
    }

    get noGuestPassesMessage() {
        return `No guest passes were found.`;
    }

    refreshComponent() {
        refreshApex(this.wiredGuestPasses);
    }

    /**
     * Utils
     */

    formatDateString(date) {
        if (date == null) return '';
        const options = {
            year: "numeric", month: "numeric", day: "numeric"
        };
        let dt = new Date( date );
        return new Intl.DateTimeFormat('en-US', options).format(dt);
    }

}