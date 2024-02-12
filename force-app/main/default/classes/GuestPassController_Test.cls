@IsTest
private class GuestPassController_Test {

    @TestSetup
    static void makeData() {
        List<TREX1__Location__c> lstLocations = TestDataFactory.createGuestPassLocations(1);
        insert lstLocations;
        Contact ct = TestDataFactory.createContacts(1).get(0);
        insert ct;
    }
    
    @IsTest
    static void testGetHostMemberships() {
        Contact ct = TestDataFactory.createContacts(1).get(0);
        insert ct;

        List<Contact> lstCtsWithAccId = [SELECT Id, AccountId FROM Contact WHERE Id = :ct.Id LIMIT 1];
        List<Guest_Pass__c> lstRecords = TestDataFactory.createHostGuestPasses(lstCtsWithAccId, 3);
        insert lstRecords;

        List<GuestPass> lstGuestPasses;
        Test.startTest();
        lstGuestPasses = GuestPassController.getHostGuestPasses(
            lstCtsWithAccId[0].AccountId
        );
        Test.stopTest();

        Assert.areEqual(
            lstRecords.size(), 
            lstGuestPasses.size(), 
            'Should have received a guest pass object for each sobject record'
        );
    }

    @IsTest
    static void testSendGuestPass() {
        List<Contact> lstCtsWithAccId = [SELECT Id, AccountId FROM Contact LIMIT 1];
        
        Guest_Pass__c record = TestDataFactory.createHostGuestPasses(lstCtsWithAccId, 1).get(0);
        insert record;

        String firstName = 'Testerooni';
        String lastName = 'Testeroodle';
        String email = 'testemail@testeroodledoodle.com';
        
        String response;
        Test.startTest();
        response = GuestPassController.sendGuestPass(
            record.Id, 
            firstName, 
            lastName, 
            email
        );
        Test.stopTest();

        Assert.areEqual('success', response, 'Should have received a successful response from the controller');

        Guest_Pass__c passToVerify = [
            SELECT Id, Guest_First_Name__c, Guest_Last_Name__c, Guest_Email__c 
              FROM Guest_Pass__c 
             WHERE Id = :record.Id
             LIMIT 1
        ];

        Assert.areEqual(firstName, passToVerify.Guest_First_Name__c, 'Should have received the provided first name');
        Assert.areEqual(lastName, passToVerify.Guest_Last_Name__c, 'Should have received the provided last name');
        Assert.areEqual(email, passToVerify.Guest_Email__c, 'Should have received the provided email');
    }

    @IsTest
    static void testSendGuestPassWithException() {
        Boolean hasException = false;

        Test.startTest();
        try {
            String response = GuestPassController.sendGuestPass(
                'invalidId', 
                'ValidFirstName', 
                'ValidLastName', 
                'validemail@invalidemail.com'
            );
        } catch (Exception e) {
            hasException = true;
        }
        Test.stopTest();

        Assert.isTrue(hasException, 'Should have received an exception for the invalid id');
    }

    @IsTest
    static void testCheckInGuestPass() {
        TREX1__Location__c scannerLocation = [SELECT Id FROM TREX1__Location__c WHERE Available_in_Guest_Pass_Scanner__c = TRUE LIMIT 1];

        Contact ct = [SELECT Id, AccountId FROM Contact LIMIT 1];

        Guest_Pass__c gp = new Guest_Pass__c();
        gp.Contact__c = ct.Id;
        gp.Status__c = GuestPassService.STATUS_VALID;
        insert gp;

        String guestPassName = [SELECT Name FROM Guest_Pass__c WHERE Id = :gp.Id LIMIT 1].Name;

        GuestPassService.ScanResult result;
        Test.startTest();
        result = GuestPassController.checkInGuestPass(guestPassName, scannerLocation.Id);
        Test.stopTest();

        Assert.isTrue(result.isSuccess, 'Should have received a successful scan result');

        Guest_Pass__c refreshedPass = [
            SELECT Status__c, Visit_Date_Time__c FROM Guest_Pass__c WHERE Id = :gp.Id LIMIT 1
        ];

        Assert.areEqual(GuestPassService.STATUS_ATTENDED, refreshedPass.Status__c, 'Pass should have a status of Attended');
        Assert.isNotNull(refreshedPass.Visit_Date_Time__c, 'Pass should have a visit date/time');
    }

    @IsTest
    static void testCheckInInvalidGuestPass() {
        TREX1__Location__c scannerLocation = [SELECT Id FROM TREX1__Location__c WHERE Available_in_Guest_Pass_Scanner__c = TRUE LIMIT 1];

        Contact ct = [SELECT Id, AccountId FROM Contact LIMIT 1];

        Guest_Pass__c gp = new Guest_Pass__c();
        gp.Contact__c = ct.Id;
        gp.Status__c = GuestPassService.STATUS_EXPIRED;
        insert gp;

        String guestPassName = [SELECT Name FROM Guest_Pass__c WHERE Id = :gp.Id LIMIT 1].Name;

        GuestPassService.ScanResult result;
        Test.startTest();
        result = GuestPassController.checkInGuestPass(guestPassName, scannerLocation.Id);
        Test.stopTest();

        Assert.isFalse(result.isSuccess, 'Should not have received a successful scan result');
    }

    @IsTest
    static void testGetScannerLocations() {
        TREX1__Location__c scannerLocation = [SELECT Id FROM TREX1__Location__c WHERE Available_in_Guest_Pass_Scanner__c = TRUE LIMIT 1];
        Test.startTest();
        List<TREX1__Location__c> lstReturnedLocations = GuestPassController.getScannerLocations();
        Test.stopTest();
        Assert.areEqual(1, lstReturnedLocations.size(), 'Should have received a single scanning location');
        Assert.areEqual(scannerLocation.Id, lstReturnedLocations[0].Id, 'Should have received the location available for the scanner app');
    }

    @IsTest
    static void testRevokePass() {
        List<Contact> lstCtsWithAccId = [SELECT Id, AccountId FROM Contact LIMIT 1];

        // Create an additional contact to share the guest pass with
        Contact guestCt = TestDataFactory.createContacts(1).get(0);
        insert guestCt;
        
        Guest_Pass__c record = TestDataFactory.createHostGuestPasses(lstCtsWithAccId, 1).get(0);
        record.Status__c = 'Invited';
        record.Contact__c = guestCt.Id;
        insert record;

        Test.startTest();
        String result = GuestPassController.revokePass(record.Id);
        Test.stopTest();

        Assert.areEqual('success', result, 'Should have received a successful response');

        Guest_Pass__c refreshedPass = [SELECT Status__c, Contact__c FROM Guest_Pass__c WHERE Id = :record.Id LIMIT 1];
        Assert.areEqual('Issued', refreshedPass.Status__c, 'Status should have returned to issued');
        Assert.isNull(refreshedPass.Contact__c, 'Contact should have been cleared');
    }

}