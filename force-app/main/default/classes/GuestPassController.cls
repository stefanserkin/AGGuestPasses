/********************************************************************
 * @description Controller for components working with guest pass data
 *  - guestPassMemberDashboard
 *  - guestPassMemberShareModal
 *  - guestPassMobileScanner
 ********************************************************************/
public with sharing class GuestPassController {

    @AuraEnabled(cacheable=true)
    public static List<GuestPass> getHostGuestPasses(
        String accountId
    ) {
        return GuestPassService.getGuestPassesForHostAccount(accountId);
    }

    @AuraEnabled(cacheable=false)
    public static String sendGuestPass(
        String guestPassId,
        String firstName,
        String lastName,
        String email
    ) {
        try {
            GuestPass pass = new GuestPass();
            pass.id = guestPassId;
            pass.guestFirstName = firstName;
            pass.guestLastName = lastName;
            pass.guestEmail = email;
            
            GuestPassService.shareGuestPass(pass);
            return 'success';
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled(cacheable=false)
    public static GuestPassService.ScanResult checkInGuestPass(
        String guestPassName, 
        String scanningLocationId
    ) {
        try {
            List<GuestPassService.ScanResult> lstScanResults = GuestPassService.checkInGuestPassesByName(
                new Set<String>{ guestPassName }, 
                scanningLocationId
            );
            return lstScanResults[0];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled(cacheable=false)
    public static String revokePass(
        String guestPassId
    ) {
        try {
            List<Guest_Pass__c> lstPasses = GuestPassService.revokeGuestPasses(
                new Set<Id>{ guestPassId }
            );
            return 'success';
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled(cacheable=true)
    public static List<TREX1__Location__c> getScannerLocations() {
        return [
            SELECT Id, Name 
              FROM TREX1__Location__c 
             WHERE Available_in_Guest_Pass_Scanner__c = true
              WITH USER_MODE 
             LIMIT 1000
        ];
    }

}