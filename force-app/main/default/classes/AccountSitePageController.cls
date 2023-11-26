public without sharing class AccountSitePageController {

    private static final String RT_NAME_MEMBERSHIP_LEAD = 'Membership';
    private static final String LEAD_STATUS_NEW = 'New - Not Contacted';
    private static final String LEAD_COMPANY_DEFAULT = 'Individual';
    private static final String LEAD_SOURCE = 'Affiliation';

    // GUEST_PASS_STATUS_VALID
    private static final String GUEST_PASS_STATUS_VALID = 'Valid';
    private static final String GUEST_PASS_SOURCE = 'Affiliation';
    
    /**
     * Get resources associated with a site page
     */
    @AuraEnabled(cacheable=true)
    public static List<Site_Page_Resource__c> getSitePageResources(String recordId) {
        try {
            return [
                SELECT Id, Name, Resource_URL__c, Sort_Order__c, Open_Link_in_New_Tab__c
                  FROM Site_Page_Resource__c
                 WHERE Account_Site_Page__c = :recordId
                 ORDER BY Sort_Order__c ASC NULLS LAST
                 LIMIT 20
            ];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    /**
     * TODO - Perform any validation against data in the database
     */
    @AuraEnabled(cacheable=false)
    public static Boolean isUserEligible() {
        return true;
    }

    /**
     * TODO - Perform any validation against data in the database
     */
    @AuraEnabled(cacheable=false)
    public static String createGuestPass(
        String firstName,
        String lastName,
        String email,
        String phone,
        String sitePageId
    ) {
        Lead ld;
        // Check for duplicate lead
        List<Lead> lstLeads = [
            SELECT Id, FirstName, LastName, Email 
              FROM Lead 
             WHERE FirstName = :firstName 
               AND LastName = :lastName
               AND (Email = :email OR Phone = :phone)
              WITH SYSTEM_MODE
             LIMIT 1
        ];
        // Get affiliate account from site page id
        List<Account> lstAccounts = [
            SELECT Id, Name 
              FROM Account 
             WHERE Id IN (SELECT Account__c FROM Account_Site_Page__c WHERE Id = :sitePageId)
              WITH SYSTEM_MODE
             LIMIT 1
        ];
        // Assign found lead or insert a new one
        if (!lstLeads.isEmpty()) {
            ld = lstLeads[0];
        } else {
            ld = new Lead();
            ld.RecordTypeId = Schema.SObjectType.Lead.getRecordTypeInfosByDeveloperName()
                .get(RT_NAME_MEMBERSHIP_LEAD).getRecordTypeId();
            ld.Status = LEAD_STATUS_NEW;
            ld.Company = lstAccounts.isEmpty() ? LEAD_COMPANY_DEFAULT : lstAccounts[0].Name;
            ld.LeadSource = LEAD_SOURCE;
            ld.FirstName = firstName;
            ld.LastName = lastName;
            ld.Email = email;
            ld.Phone = phone;
            try {
                insert ld;
            } catch (Exception e) {
                throw new AuraHandledException(e.getMessage());
            }
        }
        // Create guest pass
        Guest_Pass__c pass = new Guest_Pass__c(
            Status__c = GUEST_PASS_STATUS_VALID,
            Lead__c = ld.Id,
            Host_Account__c = lstAccounts?.get(0).Id,
            Account_Site_Page__c = sitePageId,
            Source__c = GUEST_PASS_SOURCE
        );
        try {
            insert pass;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
        // Return created pass id
        return pass.Id;
    }

}