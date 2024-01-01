public with sharing class GuestPassScannerController {

    private static final String STATUS_VALID = 'Valid';
    private static final String STATUS_ATTENDED = 'Attended';
    private static final String INVALID_NUMBER_MESSAGE = 'Invalid Guest Pass Numbers';

    @AuraEnabled(cacheable=false)
    public static String checkInGuestPass(
        String guestPassName
    ) {
        try {
            List<Guest_Pass__c> lstPasses = [
                SELECT Id, Name, Status__c, Visit_Date_Time__c
                  FROM Guest_Pass__c 
                 WHERE Name = :guestPassName
                  WITH USER_MODE
                 LIMIT 1
            ];

            if (lstPasses.isEmpty()) {
                return INVALID_NUMBER_MESSAGE;
            }

            Guest_Pass__c gp = lstPasses[0];
            if (gp.Status__c == STATUS_VALID) {
                gp.Status__c = STATUS_ATTENDED;
                gp.Visit_Date_Time__c = Datetime.now();
                update gp;
                return 'Success';
            } else {
                return 'Could not check in Guest Pass with a Status of ' + gp.Status__c;
            }
            
        } catch (Exception e) {
            System.debug(':::: received exception --> ' + e.getMessage());
            throw new AuraHandledException(e.getMessage());
        }
    }
    
}