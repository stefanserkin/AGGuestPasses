public with sharing class GuestPass {
    
    @AuraEnabled
    public String id {get; set;}

    @AuraEnabled
    public String passNumber {get; set;}

    @AuraEnabled
    public String status {get; set;}

    @AuraEnabled
    public String guestFirstName {get; set;}

    @AuraEnabled
    public String guestLastName {get; set;}

    @AuraEnabled
    public String guestEmail {get; set;}

    @AuraEnabled
    public Datetime visitDateTime {get; set;}

    @AuraEnabled
    public Date expirationDate {get; set;}
    
    @AuraEnabled
    public Date dateShared {get; set;}

}