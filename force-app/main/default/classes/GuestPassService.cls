public without sharing class GuestPassService {

    @TestVisible private static final String STATUS_VALID = 'Valid';
    @TestVisible private static final String STATUS_ATTENDED = 'Attended';

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
            if (whoId.startsWith('003')) {
                gp.Contact__c = whoId;
            } else if (whoId.startsWith('00Q')) {
                gp.Lead__c = whoId;
            }

            update gp;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    /**
     * @description For a provided list of guest pass names, update the Status
     *  to 'Attended' and record the date/time of the visit
     */
    public static void checkInGuestPassesByName(
        Set<String> setGuestPassNames
    ) {
        List<Guest_Pass__c> lstPasses = queryForGuestPassesByName(setGuestPassNames);

        List<Guest_Pass__c> lstPassesToUpdate = new List<Guest_Pass__c>();
        for (Guest_Pass__c gp : lstPasses) {
            if (gp.Status__c == STATUS_VALID) {
                gp.Status__c = STATUS_ATTENDED;
                gp.Visit_Date_Time__c = Datetime.now();
                lstPassesToUpdate.add(gp);
            }
        }

        if (!lstPassesToUpdate.isEmpty()) {
            update lstPassesToUpdate;
        }
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
        ld.RecordTypeId = Schema.SObjectType.Lead.getRecordTypeInfosByDeveloperName()
            .get('Membership').getRecordTypeId();
        ld.Company = 'Individual';
        ld.FirstName = guestPass.guestFirstName;
        ld.LastName = guestPass.guestLastName;
        ld.Email = guestPass.guestEmail;
        ld.LeadSource = 'Guest Visit';
        ld.Status = 'Open - Not Contacted';
        insert ld;
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
            SELECT Id, Name, Status__c, Visit_Date_Time__c
              FROM Guest_Pass__c 
             WHERE Name IN :setGuestPassNames
              WITH USER_MODE
             LIMIT 1
        ];
    }
    
}