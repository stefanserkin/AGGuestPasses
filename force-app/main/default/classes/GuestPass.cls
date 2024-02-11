public with sharing class GuestPass {
    
    /**
     * The record id of the guest pass
     */
    @AuraEnabled
    public String id {get; set;}

    /**
     * The Name value of the guest pass
     */
    @AuraEnabled
    public String passNumber {get; set;}

    /**
     * Valid values: Shared, Expired, Available
     * Guest Pass SObject values: Issued, Invited, Valid, Attended, Expired
     */
    @AuraEnabled
    public String status {get; set;}

    /**
     * Guest information
     */
    @AuraEnabled
    public String guestFirstName {get; set;}

    @AuraEnabled
    public String guestLastName {get; set;}

    @AuraEnabled
    public String guestEmail {get; set;}

    /**
     * For a guest pass that has been checked in, the datetime of the check-in
     */
    @AuraEnabled
    public Datetime visitDateTime {get; set;}

    /**
     * The date a guest pass is expected to expire or would have expired, if unused
     */
    @AuraEnabled
    public Date expirationDate {get; set;}
    
    /**
     * The date the guest was invited
     */
    @AuraEnabled
    public Date dateShared {get; set;}

}