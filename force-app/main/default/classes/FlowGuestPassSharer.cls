/**
 * @description Invocable flow resource allows guest logic for lead/contact matching and creation
 *  to be centralized in the GuestPassService
 * 
 * @date 2024
 */
public with sharing class FlowGuestPassSharer {

    @InvocableMethod(label='Share Guest Pass' category='Guest Pass' description='Shares guest passes based on provided guest information')
    public static List<Result> shareGuestPass(List<Request> lstRequests) {
        List<Result> lstResults = new List<Result>();

        for (Request req : lstRequests) {
            // Create guest pass data wrapper
            GuestPass gp = new GuestPass();
            gp.id = req.guestPassId;
            gp.guestFirstName = req.firstName;
            gp.guestLastName = req.lastName;
            gp.guestEmail = req.email;

            // Share the guest pass with the lead/contact
            String whoId = GuestPassService.shareGuestPass(gp);

            // Return the result
            Result result = new Result();
            result.guestRecordId = whoId;
            lstResults.add(result);
        }

        return lstResults;
    }

    public class Request {
        @InvocableVariable(label='Guest Pass ID' required=true)
        public Id guestPassId;
        @InvocableVariable(label='First Name' required=true)
        public String firstName;
        @InvocableVariable(label='Last Name' required=true)
        public String lastName;
        @InvocableVariable(label='Email' required=true)
        public String email;
    }

    public class Result {
        @InvocableVariable(label='ID of Lead or Contact record')
        public String guestRecordId;
    }

}