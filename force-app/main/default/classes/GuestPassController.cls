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
        try {
            return GuestPassService.getGuestPassesForHostAccount(accountId);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
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
    public static String checkInGuestPass(
        String guestPassName
    ) {
        try {
            GuestPassService.checkInGuestPassesByName(
                new Set<String>{ guestPassName }
            );
            return 'success';
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

}