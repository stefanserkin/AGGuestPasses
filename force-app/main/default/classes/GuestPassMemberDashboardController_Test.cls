@IsTest
private class GuestPassMemberDashboardController_Test {
    
    @IsTest
    static void testGetHostMemberships() {
        Contact ct = TestDataFactory.createContacts(1).get(0);
        insert ct;
        List<Contact> lstCtsWithAccId = [SELECT Id, AccountId FROM Contact WHERE Id = :ct.Id LIMIT 1];
        List<Guest_Pass__c> lstRecords = TestDataFactory.createHostGuestPasses(lstCtsWithAccId, 3);
        insert lstRecords;

        List<GuestPass> lstGuestPasses;
        Test.startTest();
        lstGuestPasses = GuestPassMemberDashboardController.getHostGuestPasses(
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
        Contact ct = TestDataFactory.createContacts(1).get(0);
        insert ct;
        List<Contact> lstCtsWithAccId = [SELECT Id, AccountId FROM Contact WHERE Id = :ct.Id LIMIT 1];
        
        Guest_Pass__c record = TestDataFactory.createHostGuestPasses(lstCtsWithAccId, 1).get(0);
        insert record;

        String firstName = 'Testerooni';
        String lastName = 'Testeroodle';
        String email = 'testemail@testeroodledoodle.com';
        
        String response;
        Test.startTest();
        response = GuestPassMemberDashboardController.sendGuestPass(
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
            String response = GuestPassMemberDashboardController.sendGuestPass(
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
    
}