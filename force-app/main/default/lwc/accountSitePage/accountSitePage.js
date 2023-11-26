import { LightningElement, api, wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { getRecord } from 'lightning/uiRecordApi';
import getSitePageResources from '@salesforce/apex/AccountSitePageController.getSitePageResources';
import createGuestPass from '@salesforce/apex/AccountSitePageController.createGuestPass';
import NAME_FIELD from '@salesforce/schema/Account_Site_Page__c.Name';
import ACTIVE_FIELD from '@salesforce/schema/Account_Site_Page__c.Active__c';
import SHOW_RESOURCES_FIELD from '@salesforce/schema/Account_Site_Page__c.Show_Resources__c';
import SHOW_GALLERY_FIELD from '@salesforce/schema/Account_Site_Page__c.Show_Image_Gallery__c';
import SHOW_VIDEO_FIELD from '@salesforce/schema/Account_Site_Page__c.Show_Video_Player__c';
import SHOW_TITLE_FIELD from '@salesforce/schema/Account_Site_Page__c.Show_Page_Title__c';
import VIDEO_URL_FIELD from '@salesforce/schema/Account_Site_Page__c.Video_URL__c';
import SHOW_GUESTPASSES_FIELD from '@salesforce/schema/Account_Site_Page__c.Show_Guest_Pass_Form__c';
import SIDEBAR_CONTENT_FIELD from '@salesforce/schema/Account_Site_Page__c.Sidebar_Content__c';
import BODY_CONTENT_FIELD from '@salesforce/schema/Account_Site_Page__c.Body_Content__c';
import HEADER_IMAGE_FIELD from '@salesforce/schema/Account_Site_Page__c.Header_Image_URL__c';

const FIELDS = [
    NAME_FIELD,
    ACTIVE_FIELD,
    SHOW_RESOURCES_FIELD,
    SHOW_GUESTPASSES_FIELD,
    SHOW_GALLERY_FIELD,
    SHOW_VIDEO_FIELD,
    SHOW_TITLE_FIELD,
    VIDEO_URL_FIELD,
    SIDEBAR_CONTENT_FIELD,
    BODY_CONTENT_FIELD,
    HEADER_IMAGE_FIELD
];

export default class AccountSitePage extends LightningElement {
    @api recordId;
    isLoading = false;
    error;

    // Account site page settings
    accountSitePage;
    pageName;
    isActivePage = false;
    showResources = false;
    showGuestPassForm = false;
    showImageGallery = false;
    showVideoPlayer = false;
    showPageTitle = false;
    
    guestPassFormIsSubmitted = false;
    sidebarContent;
    bodyContent;
    headerImageUrl;
    wiredResources = [];
    resources;

    // User info
    firstName;
    lastName;
    email;
    phone;

    get thankYouMessage() {
        return `Thanks for your interest in Asphalt Green! Check your email for your unique pass and information on how to use it. We look forward to seeing you!`
    }

    /**
     * Get account site page record with page settings/controls
     */
    @wire(getRecord, { 
        recordId: "$recordId", 
        fields: FIELDS 
    })wiredRecord({ error, data }) {
        if (error) {
            console.error(error);
            let message = "Unknown error";
            if (Array.isArray(error.body)) {
                message = error.body.map((e) => e.message).join(", ");
            } else if (typeof error.body.message === "string") {
                message = error.body.message;
            }
            this.dispatchEvent(
                new ShowToastEvent({
                title: "Error loading contact",
                message,
                variant: "error",
                }),
            );
        } else if (data) {
            this.accountSitePage = data;
            this.pageName = this.accountSitePage.fields.Name.value;
            this.isActivePage = this.accountSitePage.fields.Active__c.value;
            this.headerImageUrl = this.accountSitePage.fields.Header_Image_URL__c.value;
            this.showResources = this.accountSitePage.fields.Show_Resources__c.value;
            this.showGuestPassForm = this.accountSitePage.fields.Show_Guest_Pass_Form__c.value;
            this.showImageGallery = this.accountSitePage.fields.Show_Image_Gallery__c.value;
            this.showVideoPlayer = this.accountSitePage.fields.Show_Video_Player__c.value;
            this.showPageTitle = this.accountSitePage.fields.Show_Page_Title__c.value;
            this.sidebarContent = this.accountSitePage.fields.Sidebar_Content__c.value;
            this.bodyContent = this.accountSitePage.fields.Body_Content__c.value;
        }
    }

    /**
     * Wire related resources set for public display
     */
    @wire(getSitePageResources, { recordId: '$recordId' })
    wiredResult(result) {
        this.isLoading = true;
        this.wiredResources = result;
        if (result.data) {
            let rows = JSON.parse( JSON.stringify(result.data) );
            rows.forEach(row => {
                row.targetBehavior = row.Open_Link_in_New_Tab__c ? '_blank' : '_self';
            });
            this.resources = rows;
            this.error = undefined;
            this.isLoading = false;
        } else if (result.error) {
            console.error(result.error);
            this.resources = undefined;
            this.error = result.error;
            this.isLoading = false;
        }
    }

    /**
     * Handle guest pass form input
     */

    handleFirstNameChange(event) {
        this.firstName = event.target.value;
    }

    handleLastNameChange(event) {
        this.lastName = event.target.value;
    }

    handleEmailChange(event) {
        this.email = event.target.value;
    }

    handlePhoneChange(event) {
        this.phone = event.target.value;
    }

    handleFormSubmission() {
        this.isLoading = true;
        const allValid = [...this.template.querySelectorAll('lightning-input')]
            .reduce((validSoFar, inputFields) => {
                inputFields.reportValidity();
                return validSoFar && inputFields.checkValidity();
            }, true);

        if (allValid) {
            createGuestPass({
                firstName: this.firstName,
                lastName: this.lastName,
                email: this.email,
                phone: this.phone,
                sitePageId: this.recordId
            }).then((result) => {
                console.log(result);
                this.guestPassFormIsSubmitted = true;
                const event = new ShowToastEvent({
                    title: 'You\'re all set!',
                    message: this.thankYouMessage,
                    variant: 'success'
                });
                this.dispatchEvent(event);
                this.isLoading = false;
            }).catch((error) => {
                this.error = error;
                console.error(this.error);
                const event = new ShowToastEvent({
                    title: 'Hmm... something went wrong',
                    message: this.getErrorMessage(),
                    variant: 'error'
                });
                this.dispatchEvent(event);
                this.isLoading = false;
            });
        }
    }


    /**
     * Handle resource library actions
     */

    handleGoToResource(event) {
        const curResource = event.currentTarget.dataset;
        window.open(curResource.url, curResource.targetBehavior);
    }

    /**
     * Utils
     */

    getErrorMessage() {
        let message = 'Unknown error';
        if (Array.isArray(this.error.body)) {
            message = this.error.body.map(e => e.message).join(', ');
        } else if (typeof this.error.body.message === 'string') {
            message = this.error.body.message;
        }
        return message;
    }

}