@IsTest
private class FlowGuestPassSharer_Test {
    
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

        FlowGuestPassSharer.Request request = new FlowGuestPassSharer.Request();
        request.guestPassId = record.Id;
        request.firstName = firstName;
        request.lastName = lastName;
        request.email = email;

        Test.startTest();
        List<FlowGuestPassSharer.Result> lstResults = FlowGuestPassSharer.shareGuestPass(
            new List<FlowGuestPassSharer.Request>{ request }
        );
        Test.stopTest();

        Assert.isNotNull(lstResults[0].guestRecordId, 'Should have received a guest record id for the contact or lead');

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

}