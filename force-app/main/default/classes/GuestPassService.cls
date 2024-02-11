public without sharing class GuestPassService {

    @TestVisible private static final String STATUS_ISSUED = 'Issued';
    @TestVisible private static final String STATUS_INVITED = 'Invited';
    @TestVisible private static final String STATUS_VALID = 'Valid';
    @TestVisible private static final String STATUS_ATTENDED = 'Attended';
    @TestVisible private static final String STATUS_EXPIRED = 'Expired';
    @TestVisible private static final string LEAD_STATUS_DEFAULT = 'Unqualified';
    @TestVisible private static final string LEAD_COMPANY_DEFAULT = 'Individual';

    // TODO Add custom labels to re-use these messages in screen flows
    private static Map<String, String> mapInvalidCheckinStatuses = new Map<String, String>{
        STATUS_ISSUED => 'No guest is associated with this guest pass', 
        STATUS_INVITED => 'The guest waiver has not yet been signed', 
        STATUS_ATTENDED => 'Guest pass has already been used', 
        STATUS_EXPIRED => 'Guest pass has expired'
    };

    private static final String LEAD_KEY_PREFIX = Lead.sObjectType.getDescribe().getKeyPrefix();
    private static final String CONTACT_KEY_PREFIX = Contact.sObjectType.getDescribe().getKeyPrefix();

    private static Id membershipLeadRecordTypeId;
    private static Id invitedGuestRecordTypeId;

    /**
     * @description Get all guest passes related to a particular host account
     */
    public static List<GuestPass> getGuestPassesForHostAccount(
        String accountId
    ) {
        return wrapGuestPasses( 
            queryForGuestPasses(accountId) 
        );
    }

    /**
     * @description Assigns a contact or lead id to a shareable guest pass
     */
    public static void shareGuestPass(
        GuestPass guestPass
    ) {
        try {
            Guest_Pass__c gp = new Guest_Pass__c(Id = guestPass.id);
            gp.Date_Shared__c = Date.today();

            // Look for contact or lead with exact match on first, last, and email
            String whoId = getMatchingWhoId(guestPass);

            // If no match was found, create new lead and assign it as the whoId
            if (String.isBlank(whoId)) {
                whoId = createLeadFromGuestInfo(guestPass).Id;
            }

            // Check keyprefix for contact or lead
            if (whoId.startsWith(CONTACT_KEY_PREFIX)) {
                gp.Contact__c = whoId;
            } else if (whoId.startsWith(LEAD_KEY_PREFIX)) {
                gp.Lead__c = whoId;
            }

            // Set status to invited
            gp.Status__c = STATUS_INVITED;

            // Update guest pass record
            Database.update(gp, AccessLevel.USER_MODE);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    /**
     * @description For a provided list of guest pass names, update the Status
     *  to 'Attended' and record the date/time of the visit
     */
    public static List<ScanResult> checkInGuestPassesByName(
        Set<String> setGuestPassNames,
        String scanningLocationId
    ) {
        System.debug('::: entered check in');
        List<ScanResult> lstScanResults = new List<ScanResult>();
        List<Guest_Pass__c> lstPasses = queryForGuestPassesByName(setGuestPassNames);
        System.debug('::: lstPasses size --> ' + lstPasses.size());

        List<Guest_Pass__c> lstPassesToUpdate = new List<Guest_Pass__c>();
        for (Guest_Pass__c gp : lstPasses) {
            Boolean hasError = false;
            String errorMessage = '';

            // Check for invalid guest pass statuses
            if (mapInvalidCheckinStatuses.containsKey(gp.Status__c)) {
                System.debug('::: contains key in invalid status');
                hasError = true;
                errorMessage = mapInvalidCheckinStatuses.get(gp.Status__c);
            }

            // Check for incorrect location
            if (gp.Location__c != scanningLocationId) {
                System.debug('::: location mismatch');
                // In the future, we might decide to block this check-in and return a failure message
                // For now, simply update the location
                gp.Location__c = scanningLocationId;
            }

            // Check in pass
            if (!hasError) {
                System.debug('::: ready to check in');
                gp.Status__c = STATUS_ATTENDED;
                gp.Visit_Date_Time__c = Datetime.now();
                lstPassesToUpdate.add(gp);
            }

            // Create scan result object to inform caller of result
            ScanResult sr = new ScanResult();
            sr.id = gp.Id;
            sr.name = gp.Name;
            sr.isSuccess = !hasError;
            sr.errorMessage = errorMessage;
            System.debug('::: scanresult obj --> ' + sr);
            lstScanResults.add(sr);
        }

        if (!lstPassesToUpdate.isEmpty()) {
            System.debug('::: updating passes');
            // TODO Why is this failing? Need to identify access issue before heading to prod
            // Database.update(lstPassesToUpdate, AccessLevel.USER_MODE);
            update lstPassesToUpdate;
        }

        System.debug(':::: lstScanResults --> ' + lstScanResults);
        return lstScanResults;
    }

    /**
     * @description Create a GuestPass object from Guest_Pass__c SObject
     */
    private static List<GuestPass> wrapGuestPasses(
        List<Guest_Pass__c> lstRecords
    ) {
        List<GuestPass> lstPasses = new List<GuestPass>();
        for (Guest_Pass__c record : lstRecords) {
            GuestPass pass = new GuestPass();
            pass.id = record.Id;
            pass.passNumber = record.Name;
            pass.expirationDate = record.Expiration_Date__c;
            // Set status to 'Shared', 'Available', or Expired
            // Shared passes will have guest data
            if (record.Guest_First_Name__c != null) {
                pass.status = 'Shared';
                pass.guestFirstName = record.Guest_First_Name__c;
                pass.guestLastName = record.Guest_Last_Name__c;
                pass.guestEmail = record.Guest_Email__c;
                pass.dateShared = record.Date_Shared__c;
                pass.visitDateTime = record.Visit_Date_Time__c;
            } 
            else if (record.Status__c == 'Expired') {
                pass.status = 'Expired';
            } 
            else {
                pass.status = 'Available';
            }
            lstPasses.add(pass);
        }
        return lstPasses;
    }

    /**
     * @description Checks for matching contacts or leads
     *  If no match is found, an empty string is returned
     */
    private static String getMatchingWhoId(
        GuestPass guestPass
    ) {
        String returnString = '';

        // Look for contact with exact match on first, last, and email
        List<Contact> lstContacts = [
            SELECT Id 
              FROM Contact 
             WHERE FirstName = :guestPass.guestFirstName 
               AND LastName = :guestPass.guestLastName 
               AND Email = :guestPass.guestEmail 
              WITH SYSTEM_MODE
             LIMIT 1
        ];
        if (!lstContacts.isEmpty()) {
            returnString = String.valueOf( lstContacts[0].Id );
        }

        // Look for lead with exact match on first, last, and email
        List<Lead> lstLeads = [
            SELECT Id 
              FROM Lead 
             WHERE FirstName = :guestPass.guestFirstName 
               AND LastName = :guestPass.guestLastName 
               AND Email = :guestPass.guestEmail 
              WITH SYSTEM_MODE
             LIMIT 1
        ];
        if (!lstLeads.isEmpty()) {
            returnString = String.valueOf( lstLeads[0].Id );
        }

        return returnString;
    }

    /**
     * @description Creates a new lead record and inserts it into the database
     *  based on guest information from a GuestPass object
     */
    private static Lead createLeadFromGuestInfo(
        GuestPass guestPass
    ) {
        Lead ld = new Lead();
        ld.RecordTypeId = getInvitedGuestRecordTypeId();
        ld.Company = LEAD_COMPANY_DEFAULT;
        ld.FirstName = guestPass.guestFirstName;
        ld.LastName = guestPass.guestLastName;
        ld.Email = guestPass.guestEmail;
        ld.LeadSource = 'Guest Visit';
        ld.Status = LEAD_STATUS_DEFAULT;
        Database.insert(ld, AccessLevel.SYSTEM_MODE);
        return ld;
    }

    /**
     * @description Query for guest passes related to a host account id
     */
    private static List<Guest_Pass__c> queryForGuestPasses(
        String accountId
    ) {
        return [
            SELECT Id, Name, Status__c, Guest_First_Name__c, Guest_Last_Name__c, 
                   Guest_Email__c, Visit_Date_Time__c, Expiration_Date__c, Date_Shared__c
              FROM Guest_Pass__c
             WHERE Host_Account__c = :accountId
              WITH USER_MODE
             ORDER BY Guest_First_Name__c ASC NULLS FIRST, Name ASC
        ];
    }

    /**
     * @description Query for guest passes based on a set of guest pass names
     */
    private static List<Guest_Pass__c> queryForGuestPassesByName(
        Set<String> setGuestPassNames
    ) {
        return [
            SELECT Id, Name, Status__c, Visit_Date_Time__c, Location__c, Location__r.Name
              FROM Guest_Pass__c 
             WHERE Name IN :setGuestPassNames
              WITH USER_MODE
             LIMIT 1
        ];
    }

    /**
     * @description Retrieve Lead membership record type id
     */
    @TestVisible
    private static Id getMembershipLeadRecordTypeId() {
        if (membershipLeadRecordTypeId == null) {
            membershipLeadRecordTypeId = Schema.SObjectType.Lead.getRecordTypeInfosByDeveloperName()
                .get('Membership').getRecordTypeId();
        }
        return membershipLeadRecordTypeId;
    }

    /**
     * @description Retrieve Lead membership record type id
     */
    @TestVisible
    private static Id getInvitedGuestRecordTypeId() {
        if (invitedGuestRecordTypeId == null) {
            invitedGuestRecordTypeId = Schema.SObjectType.Lead.getRecordTypeInfosByDeveloperName()
                .get('Invited_Guest').getRecordTypeId();
        }
        return invitedGuestRecordTypeId;
    }

    /**
     * @description Data wrapper to represent a scan result
     */
    public class ScanResult {
        @AuraEnabled
        public String id {get; set;}
        @AuraEnabled
        public String name {get; set;}
        @AuraEnabled
        public Boolean isSuccess {get; set;}
        @AuraEnabled
        public String errorMessage {get; set;}
    }
    
}