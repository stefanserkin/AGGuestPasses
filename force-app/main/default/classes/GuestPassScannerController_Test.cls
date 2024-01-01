@IsTest
private class GuestPassScannerController_Test {

    @IsTest
    static void testCheckInGuestPass() {
        Contact ct = TestDataFactory.createContacts(1).get(0);
        insert ct;

        Guest_Pass__c gp = new Guest_Pass__c();
        gp.Contact__c = ct.Id;
        gp.Status__c = GuestPassScannerController.STATUS_VALID;
        insert gp;

        String guestPassName = [SELECT Name FROM Guest_Pass__c WHERE Id = :gp.Id LIMIT 1].Name;

        String result;
        Test.startTest();
        result = GuestPassScannerController.checkInGuestPass(guestPassName);
        Test.stopTest();

        Assert.areEqual('Success', result, 'Should have received a successful message');

        Guest_Pass__c refreshedPass = [
            SELECT Status__c, Visit_Date_Time__c FROM Guest_Pass__c WHERE Id = :gp.Id LIMIT 1
        ];

        Assert.areEqual(GuestPassScannerController.STATUS_ATTENDED, refreshedPass.Status__c, 'Pass should have a status of Attended');
        Assert.isNotNull(refreshedPass.Visit_Date_Time__c, 'Pass should have a visit date/time');
    }

    @IsTest
    static void testCheckInAttendedGuestPass() {
        Contact ct = TestDataFactory.createContacts(1).get(0);
        insert ct;

        Guest_Pass__c gp = new Guest_Pass__c();
        gp.Contact__c = ct.Id;
        gp.Status__c = GuestPassScannerController.STATUS_ATTENDED;
        insert gp;

        String guestPassName = [SELECT Name FROM Guest_Pass__c WHERE Id = :gp.Id LIMIT 1].Name;

        String result;
        Test.startTest();
        result = GuestPassScannerController.checkInGuestPass(guestPassName);
        Test.stopTest();

        Assert.areNotEqual('Success', result, 'Should not have received a successful message');
    }

    @IsTest
    static void testCheckInInvalidPass() {
        String guestPassName = 'Bogus Guest Pass Name';

        String result;
        Test.startTest();
        result = GuestPassScannerController.checkInGuestPass(guestPassName);
        Test.stopTest();

        Assert.areNotEqual('Success', result, 'Should not have received a successful message');
    }
    
}