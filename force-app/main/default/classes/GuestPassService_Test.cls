@IsTest
private class GuestPassService_Test {
    
    @IsTest
    static void testGetGuestPassesForAccount() {
        Contact ct = TestDataFactory.createContacts(1).get(0);
        insert ct;
        List<Contact> lstCtsWithAccId = [SELECT Id, AccountId FROM Contact WHERE Id = :ct.Id LIMIT 1];
        List<Guest_Pass__c> lstRecords = TestDataFactory.createHostGuestPasses(lstCtsWithAccId, 3);
        insert lstRecords;

        List<GuestPass> lstGuestPasses;
        Test.startTest();
        lstGuestPasses = GuestPassService.getGuestPassesForAccount(
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
    static void testShareGuestPass() {
        Contact ct = TestDataFactory.createContacts(1).get(0);
        insert ct;
        List<Contact> lstCtsWithAccId = [SELECT Id, AccountId FROM Contact WHERE Id = :ct.Id LIMIT 1];
        
        Guest_Pass__c record = TestDataFactory.createHostGuestPasses(lstCtsWithAccId, 1).get(0);
        insert record;

        String firstName = 'Testerooni';
        String lastName = 'Testeroodle';
        String email = 'testemail@testeroodledoodle.com';

        GuestPass pass = new GuestPass();
        pass.id = record.Id;
        pass.guestFirstName = firstName;
        pass.guestLastName = lastName;
        pass.guestEmail = email;

        Test.startTest();
        GuestPassService.shareGuestPass(pass);
        Test.stopTest();

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
    static void testGetSharedGuestPasses() {
        insert TestDataFactory.createContacts(2);
        List<Contact> lstContacts = [SELECT Id, AccountId FROM Contact LIMIT 2];
        Contact hostContact = lstContacts[0];
        Contact guestContact = lstContacts[1];

        Guest_Pass__c guestPass = TestDataFactory.createHostGuestPasses(
            new List<Contact>{ hostContact }, 
            1
        ).get(0);
        guestPass.Contact__c = guestContact.Id;
        guestPass.Date_Shared__c = Date.today();
        insert guestPass;

        List<GuestPass> lstGuestPasses;
        Test.startTest();
        lstGuestPasses = GuestPassService.getGuestPassesForAccount(
            hostContact.AccountId
        );
        Test.stopTest();

        Assert.isNotNull(lstGuestPasses[0].guestFirstName, 'Shared passes should have a guest first name');
    }
    
}