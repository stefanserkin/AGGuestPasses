public with sharing class GuestPassScannerController {

    @TestVisible private static final String STATUS_VALID = 'Valid';
    @TestVisible private static final String STATUS_ATTENDED = 'Attended';
    private static final String INVALID_NUMBER_MESSAGE = 'Invalid Guest Pass Numbers';

    // Currently not restricting the location of the guest
    // private static final String INVALID_LOCATION_MESSAGE = 'This guest pass is for the {0} location';

    // Cached map stores names of locations to their ids
    // private static Map<String, Id> mapLocationNameToId;

    @AuraEnabled(cacheable=false)
    public static String checkInGuestPass(
        String guestPassName, 
        String scannerLocationId
    ) {
        try {
            System.debug(':::: scannerLocationId --> ' + scannerLocationId);
            List<Guest_Pass__c> lstPasses = searchForPass(guestPassName);

            // If no passes exist for the guestPassName, return early
            if (lstPasses.isEmpty()) {
                return INVALID_NUMBER_MESSAGE;
            }

            Guest_Pass__c gp = lstPasses[0];
            gp.Notes__c = 'scannerLocationId --> ' + scannerLocationId + ' | gp location id --> ' + gp.Location__c;

            // Check the pass location against the scanner location
            if (String.valueOf(gp.Location__c) != scannerLocationId) {
                // Update the pass's location
                System.debug(':::: setting location to --> ' + scannerLocationId);
                gp.Location__c = scannerLocationId;
                // Might choose to throw an error message if the pass is for a different location
                /*
                List<Object> params = new List<Object> { gp.Location__r.Name };
                return String.format(INVALID_LOCATION_MESSAGE, params);
                */
            }

            if (gp.Status__c == STATUS_VALID) {
                gp.Status__c = 'Expired'; // STATUS_ATTENDED;
                gp.Visit_Date_Time__c = Datetime.now();
                Database.update(gp, AccessLevel.USER_MODE);
                return 'Success';
            } else {
                return 'Could not check in Guest Pass with a ' + gp.Status__c + ' status';
            }
            
        } catch (Exception e) {
            System.debug(':::: received exception --> ' + e.getMessage());
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled(cacheable=true)
    public static List<TREX1__Location__c> getScannerLocations() {
        try {
            return [
                SELECT Id, Name 
                  FROM TREX1__Location__c 
                 WHERE Available_in_Guest_Pass_Scanner__c = true
                  WITH USER_MODE 
                 LIMIT 1000
            ];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    private static List<Guest_Pass__c> searchForPass(
        String guestPassName
    ) {
        return [
            SELECT Id, Name, Status__c, Visit_Date_Time__c, Notes__c, Location__c, Location__r.Name
              FROM Guest_Pass__c 
             WHERE Name = :guestPassName
              WITH USER_MODE
             LIMIT 1
        ];
    }

    /*
    private static Id getLocationIdByName(
        String locationName
    ) {
        if (mapLocationNameToId == null) {
            mapLocationNameToId = new Map<String, Id>();
            for (TREX1__Location__c loc : [SELECT Id, Name 
                                             FROM TREX1__Location__c 
                                             WITH USER_MODE]) 
            {
                mapLocationNameToId.put(loc.Name, loc.Id);
            }
        }
        return mapLocationNameToId.get(locationName);
    }
    */
    
}