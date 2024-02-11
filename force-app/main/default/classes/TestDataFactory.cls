@isTest
public class TestDataFactory {
    
    /***********************************
     * Static variables
     ***********************************/    

    private static Id householdRecordTypeId;
    private static Id organizationRecordTypeId;
    private static Id standardRateRTId;
    private static Id incrementalRateRTId;
    private static Id rentalContractRentalRTId;
    private static Id facilityBookingRTId;
    private static Id standardTransactionRecTypeId;
    private static Id manualAdjustmentTLIRecTypeId;
    private static Id punchPassRecTypeId;
    private static Id membershipTypePunchPassRecTypeId;
    private static Id membershipCategoryPunchPassRecTypeId;
    
    private static Id globalBillingGroupId;
    private static String glCodeAccountsReceivable;
    private static Map<String, Id> mapProcessorProfileNameToId;
    private static Integer caseCount = 0;
    
    /***********************************
     * Constants
     ***********************************/

    // AccessDevices
    private static final String ACCESSDEVICE_BASE_NAME = 'Test Scanner';
    private static final String ACCESSDEVICE_AREA_ENTRANCE = 'Entrance';
    private static final String ACCESSDEVICE_FLOOR_1 = '1st Floor';
    // Accounting Events (TREX1)
    private static final String AE_TYPE_MANUAL_ADJUSTMENT = 'Manual Adjustment';
    // Accounts
	private static final String ACCOUNT_BASE_NAME = 'Wright Household';
    private static final String ORGANIZATION_BASE_NAME = 'Big Corp';
    // Affiliations (npsp)
    private static final String AFFILIATION_STATUS_CURRENT = 'Current';
    private static final String AFFILIATION_STATUS_FORMER = 'Former';
    // App Config (TREX1)
    private static final Integer DAYS_UNTIL_CREDITS_EXPIRE = 365;
    // Availability Profiles (TREX1)
    private static final String AVAILABILITY_PROFILE_BASE_NAME = 'Test Default';
    private static final String AVAILABILITY_PROFILE_DAILY_HOURS = '12:00am-11:59pm';
    // Bookings (TREX1)
    private static final Integer BOOKING_SETUP_TIME_REQUIRED = 0;
    private static final Integer BOOKING_TEAR_DOWN_TIME_REQUIRED = 0;
    private static final String BOOKING_STATUS = 'Draft';
    private static final String BOOKING_RATE_DETAILS = '';
    private static final Decimal BOOKING_RATE = 0;
    private static final String BOOKING_EVENT_NAME = 'Test Rental';
    private static final String RENTAL_BOOKING_TYPE = 'Rental';
    private static final String ADMIN_BOOKING_TYPE = 'Administrative';
    private static final String CALCULATION_MODE_AUTOMATIC = 'Automatic';
    // Cases
    private static final String CASE_STATUS_NEW = 'New';
    private static final String CASE_PRIORITY_MEDIUM = 'Medium';
    private static final String CASE_ORIGIN_INTERNAL = 'Internal';
    private static final String CASE_SUBJECT_BASE = 'Test Case';
    // Community Programs (pmdm)
    private static final String COMMUNITY_PROGRAM_BASE_NAME = 'Test Program';
    private static final String COMMUNITY_PROGRAM_STATUS_ACTIVE = 'Active';
    // Contacts
    private static final String CONTACT_BASE_FIRST_NAME = 'David';
    private static final String CONTACT_BASE_MIDDLE_NAME = 'Captain';
    private static final String CONTACT_BASE_LAST_NAME = 'Wright';
    private static final Date CONTACT_BASE_BIRTHDATE = Date.today().addYears(-21);
    // Course Options (TREX1)
    private static final String COURSE_OPTION_TYPE_STANDARD = 'Standard Course Option';
    // Facilities (TREX1)
    private static final String FACILITY_BASE_NAME = 'Test Facility';
    private static final String FACILITY_TYPE = 'Gym';
    // Functions (TREX1)
    private static final String FUNCTION_BASE_NAME = 'Test Function';
    private static final String BCO_BASE_NAME = 'Test BCO';
    // GL Accounts (TREX1)
    private static final String GL_ACCOUNT_BASE_NAME = 'GL Account ';
    private static final String GL_ACCOUNT_BASE_CODE = '44-44-444-4444';
    private static final String GL_ACCOUNT_TYPE_INCOME = 'Income';
    private static final String FUND_GL_CODE = '44-44-444-44444';
    // Global Billing Groups (TREX1)
    private static final String GBG_NAME = 'Asphalt Green';
    private static final Integer GBG_BILLING_DAY = 1;
    private static final String GBG_COMMUNITY_BILL_TO_ACCOUNT = 'Disabled';
    private static final String GBG_SURCHARGE_CONFIGURATION = 'Disabled';
    // Global GL Accounts (TREX1)
    private static final String GL_CODE_AR = '10-10-000-12504';
    private static final String GL_CODE_DEFERRED = '10-10-000-23001';
    private static final String GL_CODE_CASH = '10-10-000-10020';
    private static final String GL_CODE_CREDIT_CARD = '10-10-000-10023';
    private static final String GL_CODE_EXPIRED_CREDITS = '10-10-711-49505';
    // Groups
    private static final String PUBLIC_GROUP_NAME = 'Test Group Test';
    private static final String GROUP_TYPE_REGULAR = 'Regular';
    // Guest Passes
    private static final String GUEST_PASS_STATUS_ISSUED = 'Issued';
    private static final String GUEST_PASS_STATUS_INVITED = 'Invited';
    private static final String GUEST_PASS_STATUS_VALID = 'Valid';
    private static final String GUEST_PASS_SOURCE_MEMBERSHIP = 'Membership';
    // Journal Entries (TREX1)
    public static final String ADJUSTMENT_TYPE_DEBIT = 'Debit';
    public static final String ADJUSTMENT_TYPE_CREDIT = 'Credit';
    public static final String JE_TYPE_MANUAL_ADJUSTMENT = 'Manual Adjustment';
    // Locations (TREX1)
    private static final String LOCATION_BASE_NAME = 'Flushing';
    // Memberships (TREX1)
    private static final String VALID_MEMBERSHIP_CATEGORY = 'Pilates';
    private static final String MEMBERSHIP_STATUS_ACTIVE = 'Active';
    private static final String MEMBERSHIP_STATUS_COMPLETE = 'Complete';
    // Membership Categories (TREX1)
    private static final String MEMBERSHIP_CATEGORY_BASE_NAME = 'Test Membership Category';
    // Processor Profiles (tpay)
    private static final String PROFILE_NAME_VANTIV = 'Vantiv IP Settings';
    private static final String PROFILE_NAME_NONINTEGRATED = 'Non-Integrated Processor';
    private static final String VIP_ACCEPTOR_ID = '3928907';
    private static final String VIP_ACCOUNT_ID = '1012840';
    private static final String VIP_ACCOUNT_TOKEN = 'E025C80579D6CD4CF45EB7561CD7CA451FC828DE59C1E683DCE23FEC62DBFCB681713401';
    // Programs (TREX1)
    private static final String PROGRAM_BASE_NAME = 'Test Program';
    // Registrations (TREX1)
    private static final String REGISTRATION_STATUS_PENDING_ACTIVE = 'Pending Active';
    private static final String REGISTRATION_STATUS_ACTIVE = 'Active';
    private static final String REGISTRATION_STATUS_COMPLETE = 'Complete';
    // Rental Contracts (TREX1)
    private static final String RENTAL_CONTRACT_PAYMENT_OPTION = 'On Transaction Firm';
    private static final String RENTAL_CONTRACT_STATUS = 'Draft';
    // Rental Rates
    private static final String RENTAL_RATE_BASE_NAME = 'Test Rental Rate';
    private static final String INCREMENTAL_RATE_RT_NAME = RentalRateUtilities.INCREMENTAL_RECORD_TYPE_NAME;
    private static final String STANDARD_RATE_RT_NAME = RentalRateUtilities.STANDARD_RECORD_TYPE_NAME;
    // Rules (TREX1)
    private static final String RULE_BASE_NAME = 'Test Rule';
    // Scheduled Rules
    private static final String SCHEDULED_RULE_BASE_NAME = 'Test Scheduled Rule';
    private static final String SCHEDULED_RULE_DESCRIPTION = 'A scheduled rule for testing';
    // Services (pmdm)
    private static final String SERVICE_BASE_NAME = 'Test Service';
    private static final String SERVICE_STATUS_ACTIVE = 'Active';
    private static final String SERVICE_ATTENDANCE_FIELD_SET = 'Attendance_Service_Deliveries';
    private static final String SERVICE_BULK_DELIVERY_FIELD_SET = 'Bulk_Service_Deliveries';
    private static final String SERVICE_UNIT_OF_MEASUREMENT = 'Hours';
    // Service Schedules (pmdm)
    private static final String SERVICE_SCHEDULE_BASE_NAME = 'Test Schedule';
    private static final Integer SERVICE_SCHEDULE_DEFAULT_SERVICE_QUANTITY = 1;
    // Service Participants (pmdm)
    private static final String SERVICE_PARTICIPANT_STATUS_ENROLLED = 'Enrolled';
    // Staff (TREX1)
    private static final String STAFF_NAME = 'Ince Structor';
    // Tender Types (tpay)
    private static final String TENDER_TYPE_CASH = 'Cash';
    private static final String TENDER_TYPE_CHECK = 'Check';
    private static final String NONINTEGRATED_TYPE_CASH = 'Cash';
    private static final String NONINTEGRATED_TYPE_CHECK = 'Physical Check';
    private static final String TENDER_TYPE_CC = 'Credit Card';
    private static final String CARD_TYPE_NON_INTEGRATED = 'Non-Integrated';
    private static final String CARD_TYPE_CC = 'Credit';
    private static final String CARD_SCHEME_VISA = 'Visa';
    // Transactions (TREX1)
    private static final String TRANSACTION_STATUS_CLOSE = 'Close';
    private static final String TRANSACTION_STATUS_DRAFT = 'Draft';
    private static final String TRANSACTION_RECEIPT_NAME = 'Receipt-039483628948267346';
    // Transaction Line Items (TREX1)
    private static final String TLI_EVENT_TYPE_MANUAL_ADJUSTMENT = 'Manual Adjustment';
    private static final String TLI_STATUS_COMPLETE = 'Complete';
    private static final String TLI_STATUS_DRAFT = 'Draft';
    private static final String TLI_TYPE = 'Item Event';
    // Users
    private static final String EMAIL_ENCODING_KEY = 'UTF-8';
    private static final String STANDARD_USER_USERNAME = 'standarduser' + DateTime.now().getTime() + '@agtests.com';
    private static final String STANDARD_USER_EMAIL = 'testing@testthings.com';
    private static final String STANDARD_USER_FIRSTNAME = 'Tester';
    private static final String STANDARD_USER_LASTNAME = 'Testerson';
    private static final String STANDARD_USER_ALIAS = 'tester';
    private static final String STANDARD_USER_NICKNAME = 'TestUser193948';
    private static final String STANDARD_USER_PROFILE_NAME = 'Standard User';


    /***********************************
     * AccessDevices
     ***********************************/

    /**
     * Create accessdevices
     * No DML - returns unsaved list of sObjects
     * @param TREX1__Location__c Traction Rec location sobject
     * @param Integer number of records
     */

    public static List<AccessDevice__c> createAccessDevices(
        TREX1__Location__c location,
        Integer numberOfRecords
    ) {
        List<AccessDevice__c> lstDevices = new List<AccessDevice__c>();
        for (Integer i = 0; i < numberOfRecords; i++) {
            lstDevices.add( 
                new AccessDevice__c(
                    Name = ACCESSDEVICE_BASE_NAME + String.valueOf(i),
                    Active__c = true,
                    Area__c = ACCESSDEVICE_AREA_ENTRANCE,
                    Floor__c = ACCESSDEVICE_FLOOR_1,
                    Location__c = location.Id
                )
            );
        }
        return lstDevices;
    }


    /***********************************
     * AccessSwipes
     ***********************************/

    /**
     * Create accessswipes for a collection of contacts and accessdevices
     * Specify the number of swipes per contact
     * Swipes are assigned to devices sequentially
     * No DML - returns unsaved list of sObjects
     * @param List<AccessDevice__c> Traction Rec location sobject
     * @param List<Contact> list of contacts to create swipes for
     * @param Integer number of swipes per contact
     */

    public static List<AccessSwipes__c> createAccessSwipes(
        List<AccessDevice__c> lstDevices,
        List<Contact> lstContacts,
        Integer numRecordsPerContact
    ) {
        List<AccessSwipes__c> lstSwipes = new List<AccessSwipes__c>();
        Integer deviceIndex = 0;
        for (Contact ct : lstContacts) {
            for (Integer i = 0; i < numRecordsPerContact; i++) {
                AccessDevice__c device = lstDevices.size() > deviceIndex + 1
                    ? lstDevices.get(deviceIndex)
                    : lstDevices.get( Math.mod(deviceIndex, lstDevices.size()) );
                lstSwipes.add( 
                    new AccessSwipes__c(
                        Contact__c = ct.Id,
                        AccessDevice__c = device.Id,
                        DeviceName__c = device.Name,
                        SwipeTime__c = Datetime.now().addDays(i * -1).addHours(i * -1)
                    )
                );
                deviceIndex++;
            }
        }
        return lstSwipes;
    }


    /***********************************
     * Accounting Events (TREX1)
     ***********************************/

    /**
     * Create accounting event for a manual adjustment
     * No DML - returns unsaved list of sObjects
     * @param TREX1__Transaction__c parent transaction
     * @param TREX1__Transaction_Line_Item__c parent tli
     * @param Decimal manual adjustment amount
     */

    public static TREX1__Accounting_Event__c createManualAdjustmentAccountingEvent(
        TREX1__Transaction__c trans,
        TREX1__Transaction_Line_Item__c tli,
        Decimal amount
    ) {
        TREX1__Accounting_Event__c ae = new TREX1__Accounting_Event__c();
        ae.TREX1__Transaction__c = trans.Id;
        ae.TREX1__Transaction_Line_Item__c = tli.Id;
        ae.TREX1__Effective_Date__c = Date.today();
        ae.TREX1__Effective_Date_Time__c = Datetime.now();
        ae.TREX1__Type__c = AE_TYPE_MANUAL_ADJUSTMENT;
        ae.TREX1__Total__c = amount;
        ae.TREX1__Annotation__c = 'Balance Transfer';
        ae.TREX1__Account__c = trans.TREX1__Account__c;
        ae.TREX1__Contact__c = trans.TREX1__Contact__c;
        return ae;
    }


    /***********************************
     * Accounts
     ***********************************/

    /**
     * Create accounts with a household record type
     * No DML - returns unsaved list of sObjects
     * @param Integer Number of records to create
     */

    public static List<Account> createHouseholdAccounts(
        Integer numberOfHouseholds
    ) {
        List<Account> lstHouseholds = new List<Account>();
        if (householdRecordTypeId == null) {
            householdRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('HH_Account').getRecordTypeId();
        }
        for (Integer i = 0; i < numberOfHouseholds; i++) {
            lstHouseholds.add( 
                new Account(
                    Name = ACCOUNT_BASE_NAME + String.valueOf(i), 
                    RecordTypeId = householdRecordTypeId
                )
            );
        }
        return lstHouseholds;
    }

    /**
     * Create accounts with an organization record type
     * No DML - returns unsaved list of sObjects
     * @param Integer Number of records to create
     */

    public static List<Account> createOrganizationAccounts(
        Integer numberOfOrganizations
    ) {
        List<Account> lstOrganizations = new List<Account>();
        if (organizationRecordTypeId == null) {
            organizationRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Organization').getRecordTypeId();
        }
        for (Integer i = 0; i < numberOfOrganizations; i++) {
            lstOrganizations.add( 
                new Account(
                    Name = ORGANIZATION_BASE_NAME + String.valueOf(i), 
                    RecordTypeId = organizationRecordTypeId
                )
            );
        }
        return lstOrganizations;
    }


    /***********************************
     * Affiliations (npe5)
     ***********************************/

    /**
     * Create affiliations
     * No DML - returns unsaved list of sObjects
     * @param lstOrganizations Accounts for Contacts to be affiliated with
     * @param lstContacts Contacts to create affiliations for
     */

    public static List<npe5__Affiliation__c> createAffiliations(
        List<Account> lstOrganizations,
        List<Contact> lstContacts
    ) {
        List<npe5__Affiliation__c> lstAffiliations = new List<npe5__Affiliation__c>();
        for (Account org : lstOrganizations) {
            for (Contact ct : lstContacts) {
                lstAffiliations.add( 
                    new npe5__Affiliation__c(
                        npe5__Status__c = AFFILIATION_STATUS_CURRENT,
                        npe5__Contact__c = ct.Id,
                        npe5__Organization__c = org.Id
                    )
                );
            }
        }
        return lstAffiliations;
    }


    /***********************************
     * App Config (TREX1)
     ***********************************/

    // Record is created and inserted
    public static void createAppConfig() {
        TREX1__App_Config__c appConfig = TREX1__App_Config__c.getOrgDefaults();
        appConfig.Days_Until_Credit_Expiration__c = DAYS_UNTIL_CREDITS_EXPIRE;
        appConfig.Prevent_Credit_Exp_with_Active_BS__c = true;
        upsert appConfig;
    }

    /***********************************
     * Availability Profiles (TREX1)
     ***********************************/

    /**
     * Create availability profile
     * No DML - returns unsaved list of sObjects
     */

    public static TREX1__Availability_Profile__c createAvailabilityProfile() {
        return new TREX1__Availability_Profile__c(
            Name = AVAILABILITY_PROFILE_BASE_NAME,
            TREX1__Sunday_Hours__c = AVAILABILITY_PROFILE_DAILY_HOURS,
            TREX1__Monday_Hours__c = AVAILABILITY_PROFILE_DAILY_HOURS,
            TREX1__Tuesday_Hours__c = AVAILABILITY_PROFILE_DAILY_HOURS,
            TREX1__Wednesday_Hours__c = AVAILABILITY_PROFILE_DAILY_HOURS,
            TREX1__Thursday_Hours__c = AVAILABILITY_PROFILE_DAILY_HOURS,
            TREX1__Friday_Hours__c = AVAILABILITY_PROFILE_DAILY_HOURS,
            TREX1__Saturday_Hours__c = AVAILABILITY_PROFILE_DAILY_HOURS
        );
    }

     
    /***********************************
     * Booking Contract Options (TREX1)
     ***********************************/

    /**
     * Create booking contract options for a list of facilities and functions
     * No DML - returns unsaved list of sObjects
     * @param List<TREX1__Facility__c> List of facilities to link to functions
     * @param List<TREX1__Function__c> List of functions to link to facilities
     */

    public static List<TREX1__Booking_Contract_Option__c> createBookingContractOptions(
        List<TREX1__Facility__c> lstFacilities,
        List<TREX1__Function__c> lstFunctions
    ) {
        List<TREX1__Booking_Contract_Option__c> lstBCOs = new List<TREX1__Booking_Contract_Option__c>();
        for (TREX1__Facility__c facility : lstFacilities) {
            for (TREX1__Function__c function : lstFunctions) {
                lstBCOs.add( 
                    new TREX1__Booking_Contract_Option__c(
                        Name = BCO_BASE_NAME,
                        TREX1__Facility__c = facility.Id,
                        TREX1__Function__c = function.Id
                    )
                );
            }
        }
        return lstBCOs;
    }


    /***********************************
     * Bookings (TREX1)
     ***********************************/

    /**
     * Create admin bookings
     * Returns list of bookings committed to database
     * @param List<TREX1__Facility__c> List of facilities to book
     * @param Integer Number of records to create for each facility
     */

    public static List<TREX1__Booking__c> createAdminBookings(
        List<TREX1__Facility__c> lstFacilities,
        Integer numberOfBookings
    ) {
        TREX1__Function__c function = new TREX1__Function__c(
            Name = FUNCTION_BASE_NAME
        );
        insert function;

        List<TREX1__Booking_Contract_Option__c> lstBCOs = new List<TREX1__Booking_Contract_Option__c>();
        for (TREX1__Facility__c facility : lstFacilities) {
            lstBCOs.add(
                new TREX1__Booking_Contract_Option__c(
                    TREX1__Facility__c = facility.Id,
                    TREX1__Function__c = function.Id
                )
            );
        }
        insert lstBCOs;

        List<TREX1__Booking__c> lstBookings = new List<TREX1__Booking__c>();
        for (Integer i = 0; i < numberOfBookings; i++) {
            lstBookings.add(
                new TREX1__Booking__c(
                    RecordTypeId = facilityBookingRTId,
                    TREX1__Type__c = ADMIN_BOOKING_TYPE,
                    TREX1__Status__c = BOOKING_STATUS,
                    TREX1__Start_Time__c = Datetime.newInstance(Date.today() + 1, Time.newInstance(i + 7, 0, 0, 0)),
                    TREX1__End_Time__c = Datetime.newInstance(Date.today() + 1, Time.newInstance(i + 8, 0, 0, 0)),
                    TREX1__Event_Name__c = BOOKING_EVENT_NAME,
                    TREX1__Setup_Time_Required__c = BOOKING_SETUP_TIME_REQUIRED,
                    TREX1__Tear_Down_Time_Required__c = BOOKING_TEAR_DOWN_TIME_REQUIRED,
                    Booking_Rate_Calculation_Mode__c = CALCULATION_MODE_AUTOMATIC
                )
            );
        }
        return lstBookings;

    }

    /**
     * Create bookings with a type of rental
     * No DML - returns unsaved list of sObjects
     * @param Integer Number of records to create
     */

    public static List<TREX1__Booking__c> createRentalBookings(
        Integer numberOfBookings
    ) {
        List<TREX1__Booking__c> lstBookings = new List<TREX1__Booking__c>();
        for (Integer i = 0; i < numberOfBookings; i++) {
            if (facilityBookingRTId == null) {
                facilityBookingRTId = Schema.SObjectType.TREX1__Booking__c.getRecordTypeInfosByDeveloperName().get('Facility').getRecordTypeId();
            }
            lstBookings.add( 
                new TREX1__Booking__c(
                    RecordTypeId = facilityBookingRTId,
                    TREX1__Type__c = RENTAL_BOOKING_TYPE,
                    TREX1__Status__c = BOOKING_STATUS,
                    TREX1__Start_Time__c = Datetime.newInstance(Date.today() + 1, Time.newInstance(i + 7, 0, 0, 0)),
                    TREX1__End_Time__c = Datetime.newInstance(Date.today() + 1, Time.newInstance(i + 8, 0, 0, 0)),
                    TREX1__Event_Name__c = BOOKING_EVENT_NAME,
                    TREX1__Setup_Time_Required__c = BOOKING_SETUP_TIME_REQUIRED,
                    TREX1__Tear_Down_Time_Required__c = BOOKING_TEAR_DOWN_TIME_REQUIRED,
                    Booking_Rate__c = BOOKING_RATE,
                    Booking_Rate_Details__c = BOOKING_RATE_DETAILS,
                    Booking_Rate_Calculation_Mode__c = CALCULATION_MODE_AUTOMATIC
                )
            );
        }
        return lstBookings;
    }

    /**
     * Create bookings with a type of rental
     * No DML - returns unsaved list of sObjects
     * @param List<TREX1__Facility__c> Facilities to book
     * @param List<TREX1__Function__c> Functions to create bookings for
     * @param TREX1__Rental_Contract__c Contract to assign bookings to
     * @param Integer Number of bookings to create for each combo
     */

    public static List<TREX1__Booking__c> createRentalBookings(
        List<TREX1__Facility__c> lstFacilities,
        List<TREX1__Function__c> lstFunctions,
        TREX1__Rental_Contract__c contract,
        Integer numberOfBookingsEach
    ) {
        if (facilityBookingRTId == null) {
            facilityBookingRTId = Schema.SObjectType.TREX1__Booking__c.getRecordTypeInfosByDeveloperName().get('Facility').getRecordTypeId();
        }

        List<TREX1__Booking__c> lstBookings = new List<TREX1__Booking__c>();

        for (TREX1__Facility__c facility : lstFacilities) {
            for (TREX1__Function__c function : lstFunctions) {
                for (Integer i = 0; i < numberOfBookingsEach; i++) {
                    Integer n = Math.mod(i, 2) == 0 ? 7 : 8;
                    Integer y = Math.mod(i, 3) == 0 ? 1 : 5;
                    lstBookings.add( 
                        new TREX1__Booking__c(
                            RecordTypeId = facilityBookingRTId,
                            TREX1__Type__c = RENTAL_BOOKING_TYPE,
                            TREX1__Status__c = BOOKING_STATUS,
                            TREX1__Start_Time__c = Datetime.newInstance(Date.today() + i, Time.newInstance(n, 0, 0, 0)),
                            TREX1__End_Time__c = Datetime.newInstance(Date.today() + i, Time.newInstance(n + y, 0, 0, 0)),
                            TREX1__Event_Name__c = BOOKING_EVENT_NAME + String.valueOf(i),
                            TREX1__Setup_Time_Required__c = BOOKING_SETUP_TIME_REQUIRED,
                            TREX1__Tear_Down_Time_Required__c = BOOKING_TEAR_DOWN_TIME_REQUIRED,
                            Booking_Rate__c = BOOKING_RATE,
                            Booking_Rate_Details__c = BOOKING_RATE_DETAILS,
                            TREX1__Facility__c = facility.Id,
                            TREX1__Function_ID__c = function.Id,
                            TREX1__Rental_Contract__c = contract.Id,
                            Booking_Rate_Calculation_Mode__c = CALCULATION_MODE_AUTOMATIC
                        )
                    );
                }
            }
        }
        return lstBookings;
    }

    /***********************************
     * Cases
     ***********************************/

    /**
     * Create case sObjects
     * No DML - returns unsaved list of sObjects
     * @param String Name of the case record type
     * @param Integer Number of cases to create
     */

    public static List<Case> createCases(
        String recordTypeName,
        Integer numberOfCases
    ) {
        Id recordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get(recordTypeName).getRecordTypeId();
        List<Case> lstCases = new List<Case>();
        for (Integer i = 0; i < numberOfCases; i++) {
            lstCases.add(
                getCaseWithDefaults(recordTypeName)
            );
        }
        return lstCases;
    }

    /**
     * Create case sObjects
     * No DML - returns unsaved list of sObjects
     * @param String Name of the case record type
     * @param Integer Number of cases to create for each contact
     * @param Contact[] List of contacts
     */

     public static List<Case> createCases(
        String recordTypeName,
        Integer numberOfCases,
        List<Contact> lstContacts
    ) {
        Id recordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get(recordTypeName).getRecordTypeId();
        List<Case> lstCases = new List<Case>();
        for (Contact ct : lstContacts) {
            for (Integer i = 0; i < numberOfCases; i++) {
                Case cs = getCaseWithDefaults(recordTypeName);
                cs.ContactId = ct.Id;
                cs.AccountId = ct.AccountId;
                lstCases.add(cs);
            }
        }
        return lstCases;
    }

    private static Case getCaseWithDefaults(
        String recordTypeName
    ) {
        Id recordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get(recordTypeName).getRecordTypeId();
        caseCount++;
        return new Case(
            RecordTypeId = recordTypeId,
            Status = CASE_STATUS_NEW,
            Priority = CASE_PRIORITY_MEDIUM,
            Subject = CASE_SUBJECT_BASE + ' ' + String.valueOf(caseCount),
            Origin = CASE_ORIGIN_INTERNAL
        );
    }

    /***********************************
     * Community Programs (pmdm)
     ***********************************/

    /**
     * Create community program sObjects
     * Object renamed from PMM managed package (Program)
     * No DML - returns unsaved list of sObjects
     * @param Integer Number of programs to create
     */

    public static List<pmdm__Program__c> createCommunityPrograms(
        Integer numberOfPrograms
    ) {
        List<pmdm__Program__c> lstCommunityPrograms = new List<pmdm__Program__c>();
        for (Integer i = 0; i < numberOfPrograms; i++) {
            lstCommunityPrograms.add(
                new pmdm__Program__c(
                    Name = COMMUNITY_PROGRAM_BASE_NAME + String.valueOf(i), 
                    pmdm__StartDate__c = Date.today().addMonths(-1), 
                    pmdm__EndDate__c = Date.today().addMonths(1), 
                    pmdm__Status__c = COMMUNITY_PROGRAM_STATUS_ACTIVE
                )
            );
        }
        return lstCommunityPrograms;
    }

    /***********************************
     * Contacts
     ***********************************/

    /**
     * Create contact sObjects without accounts
     * No DML - returns unsaved list of sObjects
     * @param Integer Number of contacts to create for each account
     */

    public static List<Contact> createContacts(
        Integer numberOfContacts
    ) {
        return generateContactsWithDefaults(numberOfContacts);
    }

    /**
     * Create contact sObjects for a preexisting list of accounts
     * No DML - returns unsaved list of sObjects
     * @param List<Account> Parent accounts for created contacts
     * @param Integer Number of contacts to create for each account
     */

    public static List<Contact> createContacts(
        List<Account> lstParentAccounts, Integer numberOfContacts
    ) {
        List<Contact> lstContacts = new List<Contact>();
        for (Account acc : lstParentAccounts) {
            List<Contact> lstAccountContacts = generateContactsWithDefaults(numberOfContacts);
            for (Contact ct : lstAccountContacts) {
                ct.AccountId = acc.Id;
            }
            lstContacts.addAll(lstAccountContacts);
        }
        return lstContacts;
    }

    /**
     * Create a list of default contacts with FirstName, LastName, Email, and Birthdate
     *     to be used by overloaded createContacts method
     * @param numberOfContacts Number of contacts to create
     */

    private static List<Contact> generateContactsWithDefaults(
        Integer numberOfContacts
    ) {
        List<Contact> lstDefaultCts = new List<Contact>();
        for (Integer i = 0; i < numberOfContacts; i++) {
            lstDefaultCts.add(
                new Contact(
                    FirstName  = CONTACT_BASE_FIRST_NAME + String.valueOf(i),
                    MiddleName = CONTACT_BASE_MIDDLE_NAME + String.valueOf(i),
                    LastName   = CONTACT_BASE_LAST_NAME + String.valueOf(i),
                    Email      = CONTACT_BASE_FIRST_NAME + CONTACT_BASE_LAST_NAME + String.valueOf(i) + '@testingstuff.com',
                    Birthdate  = CONTACT_BASE_BIRTHDATE.addYears(-i).addMonths(i)
                )
            );
        }
        return lstDefaultCts;
    }

    /***********************************
     * Course Options (TREX1)
     ***********************************/

    /**
     * Create course option and course session option sObjects 
     *   for a list of course sessions
     * Inserts course options and csos before returning collection
     * @param TREX1__Course_Session__c[] List of course sessions
     * @param Integer Number of course options to create for each course
     * @return TREX1__Course_Session_Option__c[] List of course session options
     */

    public static List<TREX1__Course_Session_Option__c> createCourseOptions(
        List<TREX1__Course_Session__c> lstCourseSessions, 
        Integer numberOfCourseOptions
    ) {
        List<TREX1__Course_Option__c> lstCourseOptions = new List<TREX1__Course_Option__c>();
        Map<String, String> mapOptionNamesToSessionIds = new Map<String, String>(); 
        for (TREX1__Course_Session__c cs : lstCourseSessions) {
            for (Integer i = 0; i < numberOfCourseOptions; i++) {
                String coName = 'Test ' + cs.Id + '-' + String.valueOf(i);
                Date startDate = Date.today().addDays(30);
                Date endDate = Date.today().addDays(60);
                lstCourseOptions.add( 
                    new TREX1__Course_Option__c(
                        Name = coName, 
                        TREX1__Type__c = COURSE_OPTION_TYPE_STANDARD, 
                        TREX1__Start_Date__c = startDate, 
                        TREX1__End_Date__c = endDate, 
                        TREX1__Start_Time__c = '1:00 PM', 
                        TREX1__End_Time__c = '2:00 PM', 
                        TREX1__Setup_Time_Required__c = 0, 
                        TREX1__Tear_Down_Time_Required__c = 0, 
                        TREX1__Capacity__c = 100, 
                        TREX1__Register_From_Date__c = Date.today(), 
                        TREX1__Register_From_Time__c = '8:30 AM', 
                        TREX1__Register_To_Date__c = endDate, 
                        TREX1__Register_To_Time__c = '10:30 PM', 
                        TREX1__Register_Online_From_Date__c = Date.today(), 
                        TREX1__Register_Online_From_Time__c = '8:30 AM', 
                        TREX1__Register_Online_To_Date__c = endDate, 
                        TREX1__Register_Online_To_Time__c = '10:30 PM'
                    )
                );
                mapOptionNamesToSessionIds.put(coName, cs.Id);
            }
        }
        insert lstCourseOptions;

        List<TREX1__Course_Session_Option__c> lstCourseSessionOptions = new List<TREX1__Course_Session_Option__c>();
        for (TREX1__Course_Option__c co : lstCourseOptions) {
            lstCourseSessionOptions.add(
                new TREX1__Course_Session_Option__c(
                    TREX1__Course_Option__c = co.Id, 
                    TREX1__Course_Session__c = mapOptionNamesToSessionIds.get(co.Name), 
                    TREX1__Option_Available__c = true, 
                    TREX1__Available_Online__c = true
                )
            );
        }
        insert lstCourseSessionOptions;

        return lstCourseSessionOptions;
    }

    /***********************************
     * Course Sessions (TREX1)
     ***********************************/

    /**
     * Create course session sObjects for a list of courses
     * No DML - returns unsaved list of sObjects
     * @param TREX1__Course__c[] List of courses
     * @param Id sessionId
     * @param Integer Number of course sessions to create for each course
     * @return TREX1__Course_Session__c[] List of course sessions
     */

    public static List<TREX1__Course_Session__c> createCourseSessions(
        List<TREX1__Course__c> lstCourses, 
        Id sessionId, 
        Integer numberOfCourseSessions
    ) {
        List<TREX1__Course_Session__c> lstCourseSessions = new List<TREX1__Course_Session__c>();
        for (TREX1__Course__c course : lstCourses) {
            for (Integer i = 0; i < numberOfCourseSessions; i++) {
                lstCourseSessions.add( 
                    new TREX1__Course_Session__c(
                        Name = 'Test ' + course.Id + '-' + String.valueOf(i),
                        TREX1__Session__c = sessionId,
                        TREX1__Course__c = course.Id,
                        TREX1__Status__c = 'Approved'
                    )
                );
            }
        }
        return lstCourseSessions;
    }

    /***********************************
     * Courses (TREX1)
     ***********************************/

    /**
     * Create course sObjects for a list of programs
     * No DML - returns unsaved list of sObjects
     * @param TREX1__Program__c[] List of programs
     * @param Integer Number of courses to create for each program
     * @return TREX1__Course__c[] List of courses
     */

    public static List<TREX1__Course__c> createCourses(
        List<TREX1__Program__c> lstPrograms, 
        Integer numberOfCourses
    ) {
        List<TREX1__Course__c> lstCourses = new List<TREX1__Course__c>();
        for (TREX1__Program__c program : lstPrograms) {
            for (Integer i = 0; i < numberOfCourses; i++) {
                lstCourses.add( 
                    new TREX1__Course__c(
                        Name = 'Test Course ' + program.Id + '-' + String.valueOf(i),
                        TREX1__Available__c = true, 
                        TREX1__Available_Online__c = true, 
                        TREX1__Program__c = program.Id
                    )
                );
            }
        }
        return lstCourses;
    }

    /***********************************
     * Facilities (TREX1)
     ***********************************/

    /**
     * Create facilities
     * No DML - returns unsaved list of sObjects
     * @param Integer Number of records to create
     */

    public static List<TREX1__Facility__c> createFacilities(
        Integer numberOfFacilities
    ) {
        List<TREX1__Facility__c> lstFacilities = new List<TREX1__Facility__c>();
        for (Integer i = 0; i < numberOfFacilities; i++) {
            lstFacilities.add( 
                new TREX1__Facility__c(
                    Name = FACILITY_BASE_NAME + String.valueOf(i),
                    TREX1__Max_Capacity__c = 100,
                    TREX1__Type__c = FACILITY_TYPE
                )
            );
        }
        return lstFacilities;
    }


    /***********************************
     * Functions (TREX1)
     ***********************************/

    /**
     * Create functions
     * No DML - returns unsaved list of sObjects
     * @param Integer Number of records to create
     */

    public static List<TREX1__Function__c> createFunctions(
        Integer numberOfFunctions
    ) {
        List<TREX1__Function__c> lstFunctions = new List<TREX1__Function__c>();
        for (Integer i = 0; i < numberOfFunctions; i++) {
            lstFunctions.add( 
                new TREX1__Function__c(
                    Name = FUNCTION_BASE_NAME + String.valueOf(i)
                )
            );
        }
        return lstFunctions;
    }


    /***********************************
     * GL Accounts (TREX1)
     ***********************************/

    /**
     * Create gl accounts
     * No DML - returns unsaved list of sObjects
     * @param Integer Number of records to create
     */

    public static List<TREX1__GL_Account__c> createGlAccounts(
        Integer numberOfAccounts
    ) {
        List<TREX1__GL_Account__c> lstGlAccounts = new List<TREX1__GL_Account__c>();
        for (Integer i = 0; i < numberOfAccounts; i++) {
            lstGlAccounts.add(
                new TREX1__GL_Account__c(
                    Name = GL_ACCOUNT_BASE_NAME + String.valueOf(i),
                    TREX1__Active__c = true,
                    TREX1__GL_Account_Number__c = GL_ACCOUNT_BASE_CODE + String.valueOf(i),
                    TREX1__Type__c = GL_ACCOUNT_TYPE_INCOME
                )
            );
        }
        return lstGlAccounts;
    }

    /***********************************
     * Global Billing Groups (TREX1)
     ***********************************/

    // Record is created and inserted
    public static TREX1__Global_Billing_Group__c createGlobalBillingGroup() {
        TREX1__Global_Billing_Group__c gbg = new TREX1__Global_Billing_Group__c();
        gbg.Name = GBG_NAME;
        gbg.TREX1__Public_Name__c = GBG_NAME;
        gbg.TREX1__Monthly_Billing_Day__c = GBG_BILLING_DAY;
        gbg.TREX1__Community_Bill_To_Account__c = GBG_COMMUNITY_BILL_TO_ACCOUNT;
        gbg.TREX1__Surcharge_Configuration__c = GBG_SURCHARGE_CONFIGURATION;
        insert gbg;
        return gbg;
    }

    // Get id for cached gbg or create gbg and return id
    public static Id getGlobalBillingGroupId() {
        if (globalBillingGroupId == null) {
            globalBillingGroupId = createGlobalBillingGroup().Id;
        }
        return globalBillingGroupId;
    }


    /***********************************
     * Global GL Accounts (TREX1)
     ***********************************/

    // Record is created and inserted
    public static TREX1__Global_GL_Accounts__c createGlobalGLAccounts() {
        TREX1__Global_GL_Accounts__c globalGls = TREX1__Global_GL_Accounts__c.getOrgDefaults();
        globalGls.TREX1__Accounts_Receivable__c = GL_CODE_AR;
        globalGls.TREX1__Deferred_Revenue_Account__c = GL_CODE_DEFERRED;
        globalGls.TREX1__High_AR_Length__c = 90;
        globalGls.TREX1__Medium_AR_Length__c = 60;
        globalGls.TREX1__Low_AR_Length__c = 30;
        globalGls.TREX1__Payment_Account_Cash__c = GL_CODE_CASH;
        globalGls.TREX1__Payment_Account_Physical_Check__c = GL_CODE_CASH;
        globalGls.TREX1__Payment_Account_Credit_Card__c = GL_CODE_CREDIT_CARD;
        globalGls.Expired_Customer_Credits__c = GL_CODE_EXPIRED_CREDITS;
        upsert globalGls;
        // Set accounts receivable gl code to static variable to return from cache in future requests
        glCodeAccountsReceivable = GL_CODE_AR;
        return globalGls;
    }

    // Get code for cached ar gl code
    public static String getAccountsReceivableGlCode() {
        if (glCodeAccountsReceivable == null) {
            glCodeAccountsReceivable = createGlobalGLAccounts().TREX1__Accounts_Receivable__c;
        }
        return glCodeAccountsReceivable;
    }


    /***********************************
     * Groups
     ***********************************/

    /**
     * Create regular public group
     * No DML - returns a single, unsaved public group
     */

    public static Group createRegularGroup() {
        Group newGroup = new Group(
            Name = PUBLIC_GROUP_NAME, 
            Type = GROUP_TYPE_REGULAR, 
            DoesIncludeBosses = false, 
            DoesSendEmailToMembers = false
        );
        return newGroup;
    }


    /***********************************
     * Guest Passes
     ***********************************/

    /**
     * Create guest passes for a list of host members
     * No DML - returns an unsaved list of guest passes
     * @param Contact[] List of contacts to be hosts of passes
     * @param Integer Number of guest passes to create for each contact
     * @return Guest_Pass__c[] List of guest passes
     */

     public static List<Guest_Pass__c> createHostGuestPasses(
        List<Contact> lstContacts,
        Integer numGuestPasses
     ) {
        List<Guest_Pass__c> lstPasses = new List<Guest_Pass__c>();
        for (Contact ct : lstContacts) {
            for (Integer i = 0; i < numGuestPasses; i++) {
                lstPasses.add(
                    new Guest_Pass__c(
                        Status__c = GUEST_PASS_STATUS_ISSUED,
                        Source__c = GUEST_PASS_SOURCE_MEMBERSHIP,
                        Host_Contact__c = ct.Id,
                        Host_Account__c = ct.AccountId
                    )
                );
            }
        }
        return lstPasses; 
    }


    /***********************************
     * Journal Entries (TREX1)
     ***********************************/

    /**
     * Create journal entries for a manual adjustment
     * @param List<TREX1__Accounting_Event__c> list of accounting events
     * @param String gl code to adjust (the other je will adjust accounts receivable)
     * @param String adjustment type - 'Debit' or 'Credit' the gl code to adjust
     * @return List<TREX1__Transaction__c> Transactions
     */

     public static List<TREX1__Journal_Entry__c> createManualAdjustmentJournalEntries(
        TREX1__Accounting_Event__c ae,
        String glCode,
        String adjustmentType
    ) {
        List<TREX1__Journal_Entry__c> lstJEs = new List<TREX1__Journal_Entry__c>();
        // Debit
        TREX1__Journal_Entry__c debit = new TREX1__Journal_Entry__c();
        debit.TREX1__Transaction__c = ae.TREX1__Transaction__c;
        debit.TREX1__Transaction_Line_Item__c = ae.TREX1__Transaction_Line_Item__c;
        debit.TREX1__Effective_Date_Time__c = Datetime.now();
        debit.TREX1__Account__c = ae.TREX1__Account__c;
        debit.TREX1__Contact__c = ae.TREX1__Contact__c;
        debit.TREX1__Accounting_Event__c = ae.Id;
        debit.TREX1__GL_Code__c = adjustmentType == ADJUSTMENT_TYPE_DEBIT ? glCode : getAccountsReceivableGlCode();
        debit.TREX1__Type__c = JE_TYPE_MANUAL_ADJUSTMENT;
        debit.TREX1__Debit__c = ae.TREX1__Total__c;
        debit.TREX1__Credit__c = 0;
        lstJEs.add(debit);
        // Credit
        TREX1__Journal_Entry__c credit = new TREX1__Journal_Entry__c();
        credit.TREX1__Transaction__c = ae.TREX1__Transaction__c;
        credit.TREX1__Transaction_Line_Item__c = ae.TREX1__Transaction_Line_Item__c;
        credit.TREX1__Effective_Date_Time__c = Datetime.now();
        credit.TREX1__Account__c = ae.TREX1__Account__c;
        credit.TREX1__Contact__c = ae.TREX1__Contact__c;
        credit.TREX1__Accounting_Event__c = ae.Id;
        credit.TREX1__GL_Code__c = adjustmentType == ADJUSTMENT_TYPE_CREDIT ? glCode : getAccountsReceivableGlCode();
        credit.TREX1__Type__c = JE_TYPE_MANUAL_ADJUSTMENT;
        credit.TREX1__Debit__c = 0;
        credit.TREX1__Credit__c = ae.TREX1__Total__c;
        lstJEs.add(credit);

        return lstJEs;
    }

    /**
     * Create journal entries that are old enough to expire, based on the Days Until Credits Expire value
     * in the org default App Config custom setting. An accounting event is created for each journal entry
     * pair. Provide the contacts (must have an account id!) and a list of gl codes to debit.
     * These journal entries and accounting events do not have transactions or tlis
     * @param List<Contact> list of contacts to receive debits. Must have an account id!
     * @param List<String> gl codes to debit. Will be assigned to contacts in the order provided and re-used if
     *   there are more contacts than gl codes
     * @param Integer number of days to backdate the journal entries
     * @param Decimal base amount to credit the first household. Each subsequent household will receive an 
     *   extra dollar
     * @return List<TREX1__Journal_Entry__c> list of created credits (AR entries)
     */

    public static List<TREX1__Journal_Entry__c> createCreditsEligibleToExpire(
        List<Contact> lstContacts, 
        List<TREX1__GL_Account__c> lstGlAccountsToDebit, 
        Integer numDaysToBackdate, 
        Decimal baseAmountToCredit
    ) {
        // Create accounting events
        List<TREX1__Accounting_Event__c> lstAes = new List<TREX1__Accounting_Event__c>();
        Decimal creditAmount = baseAmountToCredit;
        for (Contact ct : lstContacts) {
            lstAes.add(
                new TREX1__Accounting_Event__c(         
                    TREX1__Effective_Date_Time__c = Datetime.now().addDays(numDaysToBackdate*-1),
                    TREX1__Total__c = creditAmount,
                    TREX1__Account__c = ct.AccountId,
                    TREX1__Contact__c = ct.Id 
                )
            );
            creditAmount = creditAmount + 1;
        }
        insert lstAes;

        // Create journal entries for each accounting event
        Integer glIndex = 0;
        List<TREX1__Journal_Entry__c> lstJEs = new List<TREX1__Journal_Entry__c>();
        for (TREX1__Accounting_Event__c ae : lstAes) {
            TREX1__Journal_Entry__c debitJe = new TREX1__Journal_Entry__c();
            debitJe.TREX1__Debit__c = ae.TREX1__Total__c;
            debitJe.TREX1__GL_Code__c = lstGlAccountsToDebit[glIndex].TREX1__GL_Account_Number__c;
            debitJe.TREX1__Effective_Date_Time__c = ae.TREX1__Effective_Date_Time__c;
            debitJe.TREX1__Account__c = ae.TREX1__Account__c;
            debitJe.TREX1__Contact__c = ae.TREX1__Contact__c;
            debitJe.TREX1__Accounting_Event__c = ae.Id;
            lstJEs.add(debitJe);

            TREX1__Journal_Entry__c creditJe = new TREX1__Journal_Entry__c();
            creditJe.TREX1__Credit__c = ae.TREX1__Total__c;
            creditJe.TREX1__GL_Code__c = getAccountsReceivableGlCode();
            creditJe.TREX1__Effective_Date_Time__c = ae.TREX1__Effective_Date_Time__c;
            creditJe.TREX1__Account__c = ae.TREX1__Account__c;
            creditJe.TREX1__Contact__c = ae.TREX1__Contact__c;
            creditJe.TREX1__Accounting_Event__c = ae.Id;
            lstJEs.add(creditJe);

            glIndex = (glIndex + 1) < lstGlAccountsToDebit.size() ? glIndex + 1 : 0;
        }
        insert lstJEs;

        // Filter jes to only ar credits and return list
        List<TREX1__Journal_Entry__c> lstArCreditJes = new List<TREX1__Journal_Entry__c>();
        for (TREX1__Journal_Entry__c je : lstJEs) {
            if (je.TREX1__Credit__c != null && je.TREX1__Credit__c > 0) {
                lstArCreditJes.add(je);
            }
        }
        return lstArCreditJes;

    }


    /***********************************
     * Locations (TREX1)
     ***********************************/

    /**
     * Create locations
     * No DML - returns unsaved list of sObjects
     * @param Integer Number of records to create
     */

    public static List<TREX1__Location__c> createLocations(
        Integer numberOfLocations
    ) {
        List<TREX1__Location__c> lstLocations = new List<TREX1__Location__c>();
        for (Integer i = 0; i < numberOfLocations; i++) {
            lstLocations.add( 
                new TREX1__Location__c(
                    Name = LOCATION_BASE_NAME + String.valueOf(i)
                )
            );
        }
        return lstLocations;
    }

    /**
     * Create locations available for guest pass scanning
     * No DML - returns unsaved list of sObjects
     * @param Integer Number of records to create
     */

     public static List<TREX1__Location__c> createGuestPassLocations(
        Integer numberOfLocations
    ) {
        List<TREX1__Location__c> lstLocations = new List<TREX1__Location__c>();
        for (Integer i = 0; i < numberOfLocations; i++) {
            lstLocations.add( 
                new TREX1__Location__c(
                    Name = LOCATION_BASE_NAME + String.valueOf(i), 
                    Available_in_Guest_Pass_Scanner__c = true
                )
            );
        }
        return lstLocations;
    }


    /***********************************
     * Memberships (TREX1)
     ***********************************/

    /**
     * Create membership sObjects
     * No DML - returns unsaved list of sObjects
     * @param Contact membership contact
     * @param Account household
     * @param TREX1__Transaction__c parent transaction 
     */

    public static TREX1__Membership__c createCompletedPunchPassMembership(
        Contact contact, 
        Account account, 
        TREX1__Transaction__c trans
    ) {
        if (punchPassRecTypeId == null) {
            punchPassRecTypeId = getPunchPassRecordTypeId();
        }
        return new TREX1__Membership__c(
                TREX1__Contact__c = contact.Id, 
                TREX1__Account__c = account.Id, 
                RecordTypeId = punchPassRecTypeId, 
                TREX1__Status__c = MEMBERSHIP_STATUS_COMPLETE,
                TREX1__Category_Name__c = VALID_MEMBERSHIP_CATEGORY,
                TREX1__Start_Date__c = Date.today().addDays(-1),
                TREX1__Stored_Value__c = 1,
                TREX1__Purchasing_Transaction__c = trans.Id
        );
    }

    /**
     * Create membership sObjects
     * No DML - returns unsaved list of sObjects
     * @param Contact membership contact
     * @param Account household
     * @param Id parent transaction id
     * @param Id membership type id
     */

    public static TREX1__Membership__c createCompletedPunchPassesFromType(
        Contact contact, 
        Account account, 
        Id transactionId, 
        Id membershipTypeId
    ) {
        if (punchPassRecTypeId == null) {
            punchPassRecTypeId = getPunchPassRecordTypeId();
        }
        return new TREX1__Membership__c(
                TREX1__Contact__c = contact.Id, 
                TREX1__Account__c = account.Id, 
                RecordTypeId = punchPassRecTypeId, 
                TREX1__memb_Type__c = membershipTypeId, 
                TREX1__Status__c = MEMBERSHIP_STATUS_COMPLETE,
                TREX1__Category_Name__c = VALID_MEMBERSHIP_CATEGORY,
                TREX1__Start_Date__c = Date.today().addDays(-1),
                TREX1__Stored_Value__c = 1,
                TREX1__Purchasing_Transaction__c = transactionId
        );
    }

    /**
     * Create membership sObjects
     * No DML - returns unsaved list of sObjects
     * @param Contact membership contact
     * @param Account household
     * @param TREX1__Transaction__c parent transaction 
     */

    public static TREX1__Membership__c createActivePunchPassMembership(
        Contact contact, 
        Account account, 
        TREX1__Transaction__c trans
    ) {
        if (punchPassRecTypeId == null) {
            punchPassRecTypeId = getPunchPassRecordTypeId();
        }
        return new TREX1__Membership__c(
                TREX1__Contact__c = contact.Id, 
                TREX1__Account__c = account.Id, 
                RecordTypeId = punchPassRecTypeId, 
                TREX1__Status__c = MEMBERSHIP_STATUS_ACTIVE,
                TREX1__Category_Name__c = VALID_MEMBERSHIP_CATEGORY,
                TREX1__Start_Date__c = Date.today().addDays(-1),
                TREX1__Stored_Value__c = 1,
                TREX1__Purchasing_Transaction__c = trans.Id
        );
    }

    /**
     * Create membership sObjects
     * No DML - returns unsaved list of sObjects
     * @param Contact membership contact
     * @param Account household
     * @param Id parent transaction id
     * @param Id membership type id
     */

    public static TREX1__Membership__c createActivePunchPassesFromType(
        Contact contact, 
        Id accountId, 
        Id transactionId, 
        Id membershipTypeId
    ) {
        if (punchPassRecTypeId == null) {
            punchPassRecTypeId = getPunchPassRecordTypeId();
        }
        
        Id categoryId = [SELECT TREX1__Category__c FROM TREX1__Membership_Type__c WHERE Id = :membershipTypeId LIMIT 1].TREX1__Category__c;
        
        return new TREX1__Membership__c(
                TREX1__Contact__c = contact.Id, 
                TREX1__Account__c = accountId, 
                RecordTypeId = punchPassRecTypeId, 
                TREX1__memb_Type__c = membershipTypeId, 
        		TREX1__memb_Category__c = categoryId, 
                TREX1__Status__c = MEMBERSHIP_STATUS_ACTIVE, 
                TREX1__Category_Name__c = VALID_MEMBERSHIP_CATEGORY, 
                TREX1__Start_Date__c = Date.today().addDays(-1), 
                TREX1__Stored_Value__c = 1, 
                TREX1__Purchasing_Transaction__c = transactionId
        );
    }

    /**
     * Get punch pass record type id
     */

    private static Id getPunchPassRecordTypeId() {
        if (punchPassRecTypeId == null) {
            punchPassRecTypeId = Schema.SObjectType.TREX1__Membership__c.getRecordTypeInfosByDeveloperName().get('Punch_Pass_Membership').getRecordTypeId();
        }
        return punchPassRecTypeId;
    }

    
    /***********************************
     * Membership Categories (TREX1)
     ***********************************/

    /**
     * Create membership category sObjects
     * No DML - returns unsaved list of sObjects
     * @param Integer Number of membership categories to create
     */

    public static List<TREX1__Membership_Category__c> createMembershipCategories(
        Integer numberOfMembershipCategories
    ) {
        List<TREX1__Membership_Category__c> lstMembershipCategories = new List<TREX1__Membership_Category__c>();
        for (Integer i = 0; i < numberOfMembershipCategories; i++) {
            lstMembershipCategories.add(
                new TREX1__Membership_Category__c(
                    Name = VALID_MEMBERSHIP_CATEGORY,
                    TREX1__Available_For_Purchase__c = true
                )
            );
        }
        return lstMembershipCategories;
    }

    public static List<TREX1__Membership_Category__c> createPunchPassMembershipCategories(
        Integer numberOfMembershipCategories
    ) {
        List<TREX1__Membership_Category__c> lstMembershipCategories = new List<TREX1__Membership_Category__c>();

        if (membershipCategoryPunchPassRecTypeId == null) {
            membershipCategoryPunchPassRecTypeId = Schema.SObjectType.TREX1__Membership_Category__c.getRecordTypeInfosByDeveloperName().get('Punch_Pass').getRecordTypeId();
        }

        for (Integer i = 0; i < numberOfMembershipCategories; i++) {
            lstMembershipCategories.add(
                new TREX1__Membership_Category__c(
                    Name = VALID_MEMBERSHIP_CATEGORY,
                    TREX1__Available_For_Purchase__c = true, 
                    Maximum_Monthly_Appointments__c = 2, 
                    Minimum_Days_Between_Appointments__c = 2, 
                    Scheduling_Hours_Notice_Required__c = 1, 
                    Cancellation_Hours_Notice_Required__c = 1, 
                    Appointment_Time_Slot_Interval__c = 30
                )
            );
        }
        return lstMembershipCategories;
    }


    /***********************************
     * Membership Types (TREX1)
     ***********************************/

    /**
     * Create membership type sObjects
     * No DML - returns unsaved list of sObjects
     * @param List<TREX1__Membership_Category__c> list of categories
     * @param TREX1__Location__c location
     * @param Integer Number of membership types per category
     */

    public static List<TREX1__Membership_Type__c> createMembershipTypes(
        List<TREX1__Membership_Category__c> lstMembershipCategories, 
        TREX1__Location__c location, 
        Integer numberOfMembershipTypes
    ) {
        List<TREX1__Membership_Type__c> lstMembershipTypes = new List<TREX1__Membership_Type__c>();

        if (membershipTypePunchPassRecTypeId == null) {
            membershipTypePunchPassRecTypeId = Schema.SObjectType.TREX1__Membership_Type__c.getRecordTypeInfosByDeveloperName().get('Punch_Pass_Membership_Type').getRecordTypeId();
        }

        for (TREX1__Membership_Category__c cat : lstMembershipCategories) {
            for (Integer i = 0; i < numberOfMembershipTypes; i++) {
                lstMembershipTypes.add(
                    new TREX1__Membership_Type__c(
                        Name = 'Mem Type ' + String.valueOf(i),
                        Appointment_Length__c = 60,
                        RecordTypeId = membershipTypePunchPassRecTypeId,
                        TREX1__Available_For_Purchase__c = true, 
                        TREX1__Available_Online__c = true, 
                        TREX1__Can_Freeze__c = true, 
                        TREX1__Cancellation_Policy__c = 'N Days Notice', 
                        TREX1__Category__c = cat.Id, 
                        TREX1__End_Date_Setting__c = 'Fixed Length', 
                        TREX1__Location__c = location.Id, 
                        TREX1__Stored_Value__c = 5, 
                        TREX1__Term_Length__c = 90, 
                        TREX1__Term_Type__c = 'Daily'
                    )
                );
            }
        }
        return lstMembershipTypes;
    }


    /***********************************
     * Processor Profiles (tpay)
     ***********************************/

    public static Id getProcessorProfileIdByName(String profileName) {
        if (mapProcessorProfileNameToId == null) {
            mapProcessorProfileNameToId = new Map<String, Id>();
            for (tpay__Processor_Profile__c pp : createProcessorProfiles()) {
                mapProcessorProfileNameToId.put(pp.Name, pp.Id);
            }
        }
        return mapProcessorProfileNameToId.get(profileName);
    }

    private static List<tpay__Processor_Profile__c> createProcessorProfiles() {
        List<tpay__Processor_Profile__c> lstProfiles = new List<tpay__Processor_Profile__c>();
        lstProfiles.add(getVantivProfile());
        lstProfiles.add(getNonIntegratedProfile());
        return lstProfiles;
    }

    private static tpay__Processor_Profile__c getVantivProfile() {
        tpay__Processor_Profile__c vp = new tpay__Processor_Profile__c();
        vp.RecordTypeId = Schema.SObjectType.tpay__Processor_Profile__c.getRecordTypeInfosByName()
            .get(PROFILE_NAME_VANTIV).getRecordTypeId();
        vp.Name = PROFILE_NAME_VANTIV;
        vp.tpay__Active__c = true;
        vp.tpay__Capture_AVS__c = 'ZIP Optional';
        vp.tpay__Capture_CVV__c = 'Optional';
        vp.tpay__TenderEntryMethod__c = 'Present Options';
        vp.tpay__TransactionSetupRetries__c = 10;
        vp.tpay__VIP_AcceptorID__c = VIP_ACCEPTOR_ID;
        vp.tpay__VIP_AccountID__c = VIP_ACCOUNT_ID;
        vp.tpay__VIP_AccountToken__c = VIP_ACCOUNT_TOKEN;
        return vp;
    }

    private static tpay__Processor_Profile__c getNonIntegratedProfile() {
        tpay__Processor_Profile__c nip = new tpay__Processor_Profile__c();
        nip.RecordTypeId = Schema.SObjectType.tpay__Processor_Profile__c.getRecordTypeInfosByName()
            .get(PROFILE_NAME_NONINTEGRATED).getRecordTypeId();
        nip.Name = PROFILE_NAME_NONINTEGRATED;
        nip.tpay__Active__c = true;
        nip.tpay__TenderEntryMethod__c = 'Onscreen Only';
        nip.tpay__TransactionSetupRetries__c = 0;
        return nip;
    }

    
    /***********************************
     * Programs (TREX1)
     ***********************************/

    /**
     * Create program sObjects
     * No DML - returns unsaved list of sObjects
     * @param Integer Number of programs to create
     * @return TREX1__Program__c[] List of programs
     */

    public static List<TREX1__Program__c> createPrograms(
        Integer numberOfPrograms
    ) {
        List<TREX1__Program__c> lstPrograms = new List<TREX1__Program__c>();
        for (Integer i = 0; i < numberOfPrograms; i++) {
            lstPrograms.add(
                new TREX1__Program__c(
                    Name = PROGRAM_BASE_NAME + String.valueOf(i),
                    TREX1__Available__c = true,
                    TREX1__Available_Online__c = true
                )
            );
        }
        return lstPrograms;
    }


    /***********************************
     * Registrations (TREX1)
     ***********************************/

    /**
     * Create registration sObjects of the historical variety
     * No DML - returns unsaved list of sObjects
     * @param Integer Number of registrations to create for each contact
     */

    public static List<TREX1__Registration__c> createHistoricalRegistrations(
        List<Contact> lstContacts,
        Integer numberOfRegistrations
    ) {
        List<TREX1__Registration__c> lstRegistrations = new List<TREX1__Registration__c>();
        for (Contact ct : lstContacts) {
            for (Integer i = 0; i < numberOfRegistrations; i++) {
                lstRegistrations.add(
                    new TREX1__Registration__c(
                        TREX1__Contact__c = ct.Id, 
                        TREX1__Account__c = ct.AccountId, 
                        Course_Option_Names__c = 'Test Course Option', 
                        Course_Option_Codes__c = 'IMA.FA.KECODE001', 
                        Session_Name__c = 'Spring 20', 
                        Total_Fee__c = 500, 
                        Total_Paid__c = 500, 
                        TREX1__Start_Date__c = Date.newInstance(2020, 03, 01), 
                        TREX1__End_Date__c = Date.newInstance(2020, 04, 01),
                        TREX1__Registration_Status__c = 'Complete'
                    )
                );
            }
        }
        return lstRegistrations;
    }

    /**
     * Create registration sObjects for list of contacts and a course session id
     * No DML - returns unsaved list of sObjects
     * @param Contact[] lstContacts List of contacts
     * @param Id courseSessionId Course session id
     */

    public static List<TREX1__Registration__c> createRegistrations(
        List<Contact> lstContacts, 
        Id courseSessionId
    ) {
        TREX1__Course_Session__c courseSession = [
            SELECT Id, Name, TREX1__Session__c, TREX1__Session__r.Name, TREX1__Course__c, 
                   TREX1__Session__r.TREX1__Start_Date__c, TREX1__Session__r.TREX1__End_Date__c
              FROM TREX1__Course_Session__c 
             WHERE Id = :courseSessionId
             LIMIT 1
        ];

        List<TREX1__Registration__c> lstRegistrations = new List<TREX1__Registration__c>();
        for (Contact ct : lstContacts) {
            TREX1__Registration__c reg = new TREX1__Registration__c();
            reg.TREX1__Contact__c = ct.Id;
            reg.TREX1__Account__c = ct.AccountId;
            reg.TREX1__reg_Course__c = courseSession.TREX1__Course__c;
            reg.TREX1__reg_Course_Session__c = courseSession.Id;
            reg.TREX1__Start_Date__c = courseSession.TREX1__Session__r.TREX1__Start_Date__c;
            reg.TREX1__End_Date__c = courseSession.TREX1__Session__r.TREX1__End_Date__c;
            reg.TREX1__Registration_Status__c = reg.TREX1__Start_Date__c <= Date.today() && reg.TREX1__End_Date__c >= Date.today() ? 
                'Active' :
                'Complete'
            ;
            lstRegistrations.add(reg);
        }
        return lstRegistrations;
    }

    /**
     * Create registration sObjects and course option enrollments for list of
     *   contacts and a particular course session/course option combo
     * Inserts registration and coe records before return collection
     * @param Contact[] lstContacts List of contacts
     * @param TREX1__Course_Session_Option__c[] lstCSOs List of course session options
     * @return TREX1__Registration__c[] List of registrations
     */

    public static List<TREX1__Registration__c> createRegistrations(
        List<Contact> lstContacts, 
        List<TREX1__Course_Session_Option__c> lstCSOs
    ) {

        List<TREX1__Course_Session_Option__c> lstCSOsWithLookups = [
            SELECT Id, TREX1__Course_Session__r.Name, TREX1__Course_Session__r.TREX1__Session__c, 
                   TREX1__Course_Session__r.TREX1__Session__r.Name, TREX1__Course_Session__r.TREX1__Course__c, 
                   TREX1__Course_Session__r.TREX1__Course__r.TREX1__Program__c, 
                   TREX1__Course_Session__r.TREX1__Session__r.TREX1__Start_Date__c, 
                   TREX1__Course_Session__r.TREX1__Session__r.TREX1__End_Date__c, 
                   TREX1__Course_Option__c, TREX1__Course_Option__r.Name
              FROM TREX1__Course_Session_Option__c 
             WHERE Id IN :lstCSOs
             LIMIT 10000
        ];

        List<TREX1__Registration__c> lstRegistrations = new List<TREX1__Registration__c>();
        for (Contact ct : lstContacts) {
            for (TREX1__Course_Session_Option__c cso : lstCSOsWithLookups) {
                TREX1__Registration__c reg = new TREX1__Registration__c();
                reg.TREX1__Contact__c = ct.Id;
                reg.TREX1__Account__c = ct.AccountId;
                reg.TREX1__reg_Program__c = cso.TREX1__Course_Session__r.TREX1__Course__r.TREX1__Program__c;
                reg.TREX1__reg_Course__c = cso.TREX1__Course_Session__r.TREX1__Course__c;
                reg.TREX1__reg_Course_Session__c = cso.TREX1__Course_Session__r.Id;
                reg.TREX1__Start_Date__c = cso.TREX1__Course_Session__r.TREX1__Session__r.TREX1__Start_Date__c;
                reg.TREX1__End_Date__c = cso.TREX1__Course_Session__r.TREX1__Session__r.TREX1__End_Date__c;
                if (reg.TREX1__Start_Date__c > Date.today()) {
                    reg.TREX1__Registration_Status__c = REGISTRATION_STATUS_PENDING_ACTIVE;
                } else if (reg.TREX1__Start_Date__c <= Date.today() && reg.TREX1__End_Date__c >= Date.today()) {
                    reg.TREX1__Registration_Status__c = REGISTRATION_STATUS_ACTIVE;
                } else {
                    reg.TREX1__Registration_Status__c = REGISTRATION_STATUS_COMPLETE;
                }
                lstRegistrations.add(reg);
            }
        }
        insert lstRegistrations;

        // Create map of course session ids to course options
        Map<String, String> mapCourseSessionToCourseOptionId = new Map<String, String>();
        for (TREX1__Course_Session_Option__c curCso : lstCSOs) {
            mapCourseSessionToCourseOptionId.put(
                curCso.TREX1__Course_Session__c, 
                curCso.TREX1__Course_Option__c
            );
        }

        // Create a course option enrollment for each registration
        List<TREX1__Course_Option_Enrollment__c> lstCOEs = new List<TREX1__Course_Option_Enrollment__c>();
        for (TREX1__Registration__c r : lstRegistrations) {
            TREX1__Course_Option_Enrollment__c coe = new TREX1__Course_Option_Enrollment__c();
            coe.TREX1__Contact__c = r.TREX1__Contact__c;
            coe.TREX1__Registration__c = r.Id;
            coe.TREX1__Course_Option__c = mapCourseSessionToCourseOptionId.get(r.TREX1__reg_Course_Session__c);
            coe.TREX1__Start_Date__c = r.TREX1__Start_Date__c;
            if (coe.TREX1__Start_Date__c > Date.today()) {
                coe.TREX1__Status__c = REGISTRATION_STATUS_PENDING_ACTIVE;
            } else if (coe.TREX1__Start_Date__c <= Date.today() && r.TREX1__End_Date__c >= Date.today()) {
                coe.TREX1__Status__c = REGISTRATION_STATUS_ACTIVE;
            } else {
                coe.TREX1__Status__c = REGISTRATION_STATUS_COMPLETE;
            }
            lstCOEs.add(coe);
        }
        insert lstCOEs;

        return lstRegistrations;
    }

        
    /***********************************
     * Rental Contracts (TREX1)
     ***********************************/

    /**
     * Create rental contracts
     * No DML - returns unsaved list of sObjects
     * @param Integer Number of records to create
     */

    public static TREX1__Rental_Contract__c createRentalContract(
        Contact ct
    ) {
        if (rentalContractRentalRTId == null) {
            rentalContractRentalRTId = Schema.SObjectType.TREX1__Rental_Contract__c.getRecordTypeInfosByDeveloperName().get('Rental').getRecordTypeId();
        }
        return new TREX1__Rental_Contract__c(
            TREX1__Payment_Option__c = RENTAL_CONTRACT_PAYMENT_OPTION,
            TREX1__Status__c = RENTAL_CONTRACT_STATUS,
            TREX1__Contact__c = ct.Id,
            TREX1__Account__c = ct.AccountId
        );
    }

    
    /***********************************
     * Rental Rates
     ***********************************/

    /**
     * Create rental rates for a list of facilities and functions
     * No DML - returns unsaved list of sObjects
     * @param List<TREX1__Facility__c> List of facilities to link to functions
     * @param List<TREX1__Function__c> List of functions to link to facilities
     * @param Integer Number of rental rates to create for each combo
     * @param String Type of rental rate. Accepts either 'Standard_Rate' or 'Incremental_Rate'
     */

    public static List<Rental_Rate__c> createRentalRates(
        List<TREX1__Facility__c> lstFacilities,
        List<TREX1__Function__c> lstFunctions,
        Integer numberOfRentalRates,
        String typeOfRate
    ) {
        List<Rental_Rate__c> lstRentalRates = new List<Rental_Rate__c>();
        for (TREX1__Facility__c facility : lstFacilities) {
            for (TREX1__Function__c function : lstFunctions) {
                for (Integer i = 0; i < numberOfRentalRates; i++) {
                    if (typeOfRate == INCREMENTAL_RATE_RT_NAME) {
                        if (incrementalRateRTId == null) {
                            incrementalRateRTId = Schema.SObjectType.Rental_Rate__c.getRecordTypeInfosByDeveloperName().get(INCREMENTAL_RATE_RT_NAME).getRecordTypeId();
                        }
                        Rental_Rate__c rate = new Rental_Rate__c();
                        rate.Name = RENTAL_RATE_BASE_NAME;
                        rate.Facility__c = facility.Id;
                        rate.Function__c = function.Id;
                        rate.Hourly_Rate__c = 100 * (i + 1);
                        rate.RecordTypeId = incrementalRateRTId;
                        rate.Amount_of_Hours__c = (i + 1) < numberOfRentalRates ? (numberOfRentalRates - i) : 0;
                        lstRentalRates.add(rate);
                    } else {
                        if (standardRateRTId == null) {
                            standardRateRTId = Schema.SObjectType.Rental_Rate__c.getRecordTypeInfosByDeveloperName().get(STANDARD_RATE_RT_NAME).getRecordTypeId();
                        }
                        Integer timeCount = i < 12 ? i : Math.mod(i, 12);
                        Rental_Rate__c rate = new Rental_Rate__c();
                        rate.Name = RENTAL_RATE_BASE_NAME;
                        rate.Facility__c = facility.Id;
                        rate.Function__c = function.Id;
                        rate.Hourly_Rate__c = 100 * (i + 1);
                        rate.RecordTypeId = standardRateRTId;
                        rate.Is_Weekday__c = false;
                        rate.Outside_of_Hours__c = false;
                        rate.Start_Time__c = Time.newInstance(timeCount + 7, 0, 0, 0);
                        rate.End_Time__c   = Time.newInstance((timeCount + 8), 0, 0, 0);

                        Rental_Rate__c weekdayRate = new Rental_Rate__c();
                        weekdayRate.Name = RENTAL_RATE_BASE_NAME;
                        weekdayRate.Facility__c = facility.Id;
                        weekdayRate.Function__c = function.Id;
                        weekdayRate.Hourly_Rate__c = 100 * (i + 1);
                        weekdayRate.RecordTypeId = standardRateRTId;
                        weekdayRate.Is_Weekday__c = true;
                        weekdayRate.Outside_of_Hours__c = false;
                        weekdayRate.Start_Time__c = Time.newInstance(timeCount + 7, 0, 0, 0);
                        weekdayRate.End_Time__c   = Time.newInstance((timeCount + 8), 0, 0, 0);
                        
                        lstRentalRates.add(rate);
                        lstRentalRates.add(weekdayRate);
                    }
                }
            }
        }
        return lstRentalRates;
    }

    public static Map<Id, List<Rental_Rate__c>> createMapFacilityIdToRentalRates(
        List<TREX1__Facility__c> lstFacilities,
        List<TREX1__Function__c> lstFunctions,
        Integer numberOfRentalRates,
        String typeOfRate
    ) {
        Map<Id, List<Rental_Rate__c>> mapFacilityIdToRentalRates = new Map<Id, List<Rental_Rate__c>>();
        for (TREX1__Facility__c facility : lstFacilities) {
            List<Rental_Rate__c> lstRentalRates = new List<Rental_Rate__c>();
            for (TREX1__Function__c function : lstFunctions) {
                for (Integer i = 0; i < numberOfRentalRates; i++) {
                    if (typeOfRate == INCREMENTAL_RATE_RT_NAME) {
                        if (incrementalRateRTId == null) {
                            incrementalRateRTId = Schema.SObjectType.Rental_Rate__c.getRecordTypeInfosByDeveloperName().get(INCREMENTAL_RATE_RT_NAME).getRecordTypeId();
                        }
                        Rental_Rate__c rate = new Rental_Rate__c();
                        rate.Name = RENTAL_RATE_BASE_NAME;
                        rate.Facility__c = facility.Id;
                        rate.Function__c = function.Id;
                        rate.Hourly_Rate__c = 100 * (i + 1);
                        rate.RecordTypeId = incrementalRateRTId;
                        rate.Amount_of_Hours__c = (i + 1) < numberOfRentalRates ? (numberOfRentalRates - i) : 0;
                        lstRentalRates.add(rate);
                    } else {
                        if (standardRateRTId == null) {
                            standardRateRTId = Schema.SObjectType.Rental_Rate__c.getRecordTypeInfosByDeveloperName().get(STANDARD_RATE_RT_NAME).getRecordTypeId();
                        }
                        Integer timeCount = i < 12 ? i : Math.mod(i, 12);
                        Rental_Rate__c rate = new Rental_Rate__c();
                        rate.Name = RENTAL_RATE_BASE_NAME;
                        rate.Facility__c = facility.Id;
                        rate.Function__c = function.Id;
                        rate.Hourly_Rate__c = 100 * (i + 1);
                        rate.RecordTypeId = standardRateRTId;
                        rate.Is_Weekday__c = false;
                        rate.Outside_of_Hours__c = false;
                        rate.Start_Time__c = Time.newInstance(timeCount + 7, 0, 0, 0);
                        rate.End_Time__c   = Time.newInstance((timeCount + 8), 0, 0, 0);

                        Rental_Rate__c weekdayRate = new Rental_Rate__c();
                        weekdayRate.Name = RENTAL_RATE_BASE_NAME;
                        weekdayRate.Facility__c = facility.Id;
                        weekdayRate.Function__c = function.Id;
                        weekdayRate.Hourly_Rate__c = 100 * (i + 1);
                        weekdayRate.RecordTypeId = standardRateRTId;
                        weekdayRate.Is_Weekday__c = true;
                        weekdayRate.Outside_of_Hours__c = false;
                        weekdayRate.Start_Time__c = Time.newInstance(timeCount + 7, 0, 0, 0);
                        weekdayRate.End_Time__c   = Time.newInstance((timeCount + 8), 0, 0, 0);
                        
                        lstRentalRates.add(rate);
                        lstRentalRates.add(weekdayRate);
                    }
                }
            }
            mapFacilityIdToRentalRates.put(
                facility.Id, 
                lstRentalRates
            );
        }
        return mapFacilityIdToRentalRates;
    }

    
    /***********************************
     * Rules (TREX1)
     ***********************************/

    /**
     * Create rules sObjects
     * No DML - returns unsaved list of sObjects
     * @param Integer Number of rules to create
     */

    public static List<TREX1__Rule__c> createRules(
        Integer numberOfRules
    ) {
        List<TREX1__Rule__c> lstRules = new List<TREX1__Rule__c>();
        for (Integer i = 0; i < numberOfRules; i++) {
            lstRules.add( 
                new TREX1__Rule__c(Name = RULE_BASE_NAME + String.valueOf(i)) 
            );
        }
        return lstRules;
    }


    /***********************************
     * Scheduled Rules
     ***********************************/

    /**
     * Create scheduled rules sObjects for a list of rules
     * No DML - returns unsaved list of Scheduled Rule sObjects
     * @param List<TREX1__Rule__c> List of Rules to create scheduled rules for
     * @param Integer Number of scheduled rules to create for each rule
     */

    public static List<Scheduled_Rule__c> createScheduledRules(
        List<TREX1__Rule__c> lstParentRules, Integer numberOfScheduledRules
    ) {
        List<Scheduled_Rule__c> lstScheduledRules = new List<Scheduled_Rule__c>();
        for (TREX1__Rule__c rule : lstParentRules) {
            for (Integer i = 0; i < numberOfScheduledRules; i++) {
                lstScheduledRules.add(
                    new Scheduled_Rule__c(
                        Name = SCHEDULED_RULE_BASE_NAME + String.valueOf(i),
                        Rule__c = rule.Id,
                        Start_Date_Time__c = Datetime.now().addDays(i+1),
                        End_Date_Time__c = Datetime.now().addDays(i+2),
                        Description__c = SCHEDULED_RULE_DESCRIPTION
                    )
                );
            }
        }
        return lstScheduledRules;
    }

    /***********************************
     * Services (pmdm)
     ***********************************/

    /**
     * Create service sObjects for a community program
     * No DML - returns unsaved list of sObjects
     * @param pmdm__Program__c community program
     * @param Integer Number of services to create
     */

    public static List<pmdm__Service__c> createServices(
        pmdm__Program__c program, 
        Integer numberOfServices
    ) {
        List<pmdm__Service__c> lstServices = new List<pmdm__Service__c>();
        for (Integer i = 0; i < numberOfServices; i++) {
            lstServices.add(
                new pmdm__Service__c(
                    Name = SERVICE_BASE_NAME + String.valueOf(i), 
                    pmdm__Program__c = program.Id, 
                    pmdm__Status__c = SERVICE_STATUS_ACTIVE, 
                    pmdm__AttendanceFieldSet__c = SERVICE_ATTENDANCE_FIELD_SET, 
                    pmdm__ServiceDeliveryFieldSet__c = SERVICE_BULK_DELIVERY_FIELD_SET, 
                    pmdm__UnitOfMeasurement__c = SERVICE_UNIT_OF_MEASUREMENT
                )
            );
        }
        return lstServices;
    }

    /***********************************
     * Service Schedules (pmdm)
     ***********************************/

    /**
     * Create service schedule sObjects for a service
     * No DML - returns unsaved list of sObjects
     * @param pmdm__Service__c service
     * @param Integer Number of service schedules to create
     */

    public static List<pmdm__ServiceSchedule__c> createServiceSchedules(
        pmdm__Service__c service, 
        Integer numberOfSchedules
    ) {
        List<pmdm__ServiceSchedule__c> lstSchedules = new List<pmdm__ServiceSchedule__c>();
        for (Integer i = 0; i < numberOfSchedules; i++) {
            lstSchedules.add(
                new pmdm__ServiceSchedule__c(
                    Name = SERVICE_SCHEDULE_BASE_NAME + String.valueOf(i), 
                    pmdm__Service__c = service.Id, 
                    pmdm__DefaultServiceQuantity__c = SERVICE_SCHEDULE_DEFAULT_SERVICE_QUANTITY, 
                    pmdm__FirstSessionStart__c = DateTime.now(), 
                    pmdm__FirstSessionEnd__c = DateTime.now().addHours(SERVICE_SCHEDULE_DEFAULT_SERVICE_QUANTITY)
                )
            );
        }
        return lstSchedules;
    }

    /***********************************
     * Service Participants (pmdm)
     ***********************************/

    /**
     * Create service participant sObjects for a service schedule
     * No DML - returns unsaved list of sObjects
     * @param pmdm__ServiceSchedule__c service schedule
     * @param Contact[] list of contacts to enroll
     */

    public static List<pmdm__ServiceParticipant__c> createServiceParticipants(
        pmdm__ServiceSchedule__c serviceSchedule, 
        List<Contact> lstContacts
    ) {
        List<pmdm__ServiceParticipant__c> lstParticipants = new List<pmdm__ServiceParticipant__c>();
        for (Contact ct : lstContacts) {
            lstParticipants.add(
                new pmdm__ServiceParticipant__c(
                    Name = ct.FirstName + ' ' + ct.LastName + ' ' + serviceSchedule.Name, 
                    pmdm__Contact__c = ct.Id, 
                    pmdm__Service__c = serviceSchedule.pmdm__Service__c, 
                    pmdm__ServiceSchedule__c = serviceSchedule.Id, 
                    pmdm__SignUpDate__c = Date.today(), 
                    pmdm__Status__c = SERVICE_PARTICIPANT_STATUS_ENROLLED, 
                    Bypass_Auto_Emails__c = true
                )
            );
        }
        return lstParticipants;
    }

    /***********************************
     * Sessions (TREX1)
     ***********************************/

    /**
     * Create sessions
     * No DML - returns unsaved list of sObjects
     * @param Integer Number of sessions to create
     */

    public static List<TREX1__Session__c> createSessions(
        Integer numberOfSessions
    ) {
        List<TREX1__Session__c> lstSessions = new List<TREX1__Session__c>();
        for (Integer i = 0; i < numberOfSessions; i++) {
            Integer daysOffset = i * -365;
            TREX1__Session__c session = new TREX1__Session__c(
                Name = 'Session ' + String.valueOf(i),
                TREX1__Available__c = true,
                TREX1__Available_Online__c = true,
                TREX1__Available_Online_From__c = Date.today().addDays(30 + daysOffset),
                TREX1__Available_Online_To__c = Date.today().addDays(60 + daysOffset),
                TREX1__Register_From_Date__c = Date.today().addDays(30 + daysOffset),
                TREX1__Register_To_Date__c = Date.today().addDays(60 + daysOffset),
                TREX1__Register_Online_From_Date__c = Date.today().addDays(30 + daysOffset),
                TREX1__Register_Online_To_Date__c = Date.today().addDays(60 + daysOffset),
                TREX1__Start_Date__c = Date.today().addDays(30 + daysOffset),
                TREX1__End_Date__c = Date.today().addDays(60 + daysOffset),
                TREX1__Status__c = 'Available'
            );
            lstSessions.add(session);
        }
        return lstSessions;
    }

    /***********************************
     * Staff (TREX1)
     ***********************************/

    /**
     * Create staff sObjects for a list of contacts
     * No DML - returns unsaved list of Staff sObjects
     * @param List<Contact> List of Contacts to create staff for
     */

    public static List<TREX1__Staff__c> createStaffFromContacts(
        List<Contact> lstContacts
    ) {
        List<TREX1__Staff__c> lstStaff = new List<TREX1__Staff__c>();
        for (Contact ct : lstContacts) {
            lstStaff.add(
                new TREX1__Staff__c(
                    Name = ct.FirstName + ' ' + ct.LastName, 
                    Contact__c = ct.Id
                )
            );
        }
        return lstStaff;
    }

    /***********************************
     * Staff Availability Schedules
     ***********************************/

    /**
     * Create sas sObjects for a staff record
     * No DML - returns unsaved list of sas sObjects
     * @param TREX1__Staff__c Staff
     * @param Date start date
     * @param Time start time
     * @param Time end time
     * @param Id location id
     * @param Integer number of days
     */

    public static List<Staff_Availability_Schedule__c> createAvailabilityForConsecutiveDays(
        TREX1__Staff__c staff, 
        Date startDate,
        Time startTime, 
        Time endTime, 
        Id locationId, 
        Integer numberOfDays
    ) {
        List<Staff_Availability_Schedule__c> lstSchedules = new List<Staff_Availability_Schedule__c>();
        for (Integer i = 0; i < numberOfDays; i++) {
            lstSchedules.add(
                new Staff_Availability_Schedule__c(
                    Name = 'Test', 
                    Staff__c = staff.Id, 
                    Start_DateTime__c = DateTime.newInstance(startDate.addDays(i), startTime),
                    End_DateTime__c = DateTime.newInstance(startDate.addDays(i), endTime), 
                    Location__c = locationId
                )
            );
        }
        return lstSchedules;
    }


    /***********************************
     * Tender Types (tpay)
     ***********************************/

    public static void createTenderTypes() {
        List<tpay__Tender_Type__c> lstTenderTypes = new List<tpay__Tender_Type__c>();
        // Cash
        tpay__Tender_Type__c ttCash = new tpay__Tender_Type__c();
        ttCash.Non_Integrated_Type__c = NONINTEGRATED_TYPE_CASH;
        ttCash.tpay__Active__c = true;
        ttCash.tpay__CardType__c = CARD_TYPE_NON_INTEGRATED;
        ttCash.tpay__Processor_Profile__c = getProcessorProfileIdByName(PROFILE_NAME_NONINTEGRATED);
        ttCash.tpay__Tender_Label__c = TENDER_TYPE_CASH;
        ttCash.tpay__Tender_Name__c = TENDER_TYPE_CASH;
        lstTenderTypes.add(ttCash);
        // Check
        tpay__Tender_Type__c ttCheck = new tpay__Tender_Type__c();
        ttCheck.Non_Integrated_Type__c = NONINTEGRATED_TYPE_CHECK;
        ttCheck.tpay__Active__c = true;
        ttCheck.tpay__CardType__c = CARD_TYPE_NON_INTEGRATED;
        ttCheck.tpay__Processor_Profile__c = getProcessorProfileIdByName(PROFILE_NAME_NONINTEGRATED);
        ttCheck.tpay__Tender_Label__c = TENDER_TYPE_CHECK;
        ttCheck.tpay__Tender_Name__c = TENDER_TYPE_CHECK;
        lstTenderTypes.add(ttCheck);
        // Credit Card
        tpay__Tender_Type__c ttCredit = new tpay__Tender_Type__c();
        ttCredit.tpay__Active__c = true;
        ttCredit.tpay__Allow_Automated_Billing__c = true;
        ttCredit.tpay__Allow_Edit_On_Community__c = true;
        ttCredit.tpay__Available_For_Stored_Account__c = true;
        ttCredit.tpay__Card_Scheme__c = CARD_SCHEME_VISA;
        ttCredit.tpay__CardType__c = CARD_TYPE_CC;
        ttCredit.tpay__Processor_Profile__c = getProcessorProfileIdByName(PROFILE_NAME_VANTIV);
        ttCredit.tpay__Tender_Label__c = TENDER_TYPE_CC;
        ttCredit.tpay__Tender_Name__c = TENDER_TYPE_CC;
        lstTenderTypes.add(ttCredit);

        insert lstTenderTypes;

        List<GBG_Allowed_Tender_Type__c> lstAllowedGBGs = new List<GBG_Allowed_Tender_Type__c>();
        for (tpay__Tender_Type__c tt : lstTenderTypes) {
            GBG_Allowed_Tender_Type__c agbg = new GBG_Allowed_Tender_Type__c();
            agbg.Tender_Type__c = tt.Id;
            agbg.Global_Billing_Group__c = globalBillingGroupId;
            agbg.Front_Desk_Immediate__c = true;
            agbg.Front_Desk_Recurring__c = tt.tpay__CardType__c == CARD_TYPE_NON_INTEGRATED ? false : true;
            lstAllowedGBGs.add(agbg);

            // For credit cards, insert additional link for online options
            if (tt.tpay__CardType__c != CARD_TYPE_NON_INTEGRATED) {
                GBG_Allowed_Tender_Type__c oAgbg = new GBG_Allowed_Tender_Type__c();
                oAgbg.Tender_Type__c = tt.Id;
                oAgbg.Global_Billing_Group__c = globalBillingGroupId;
                oAgbg.Front_Desk_Immediate__c = false;
                oAgbg.Front_Desk_Recurring__c = false;
                oAgbg.Online_Immediate__c = true;
                oAgbg.Online_Recurring__c = true;
                lstAllowedGBGs.add(oAgbg);
            }
        }
        insert lstAllowedGBGs;
    }

    /***********************************
     * Transactions (TREX1)
     ***********************************/

    /**
     * Create a transaction for a contact and account
     * Inserts records to use id in receipt attachment
     * @param Contact transaction contact
     * @return List<TREX1__Transaction__c> Transactions
     */

    public static TREX1__Transaction__c createTransaction(
        Contact contact
    ) {
        if (standardTransactionRecTypeId == null) {
            standardTransactionRecTypeId = Schema.SObjectType.TREX1__Transaction__c.getRecordTypeInfosByDeveloperName().get('Standard').getRecordTypeId();
        }

        TREX1__Transaction__c trans = new TREX1__Transaction__c();
        trans.RecordTypeId = standardTransactionRecTypeId;
        trans.TREX1__Account__c = contact.AccountId;
        trans.TREX1__Contact__c = contact.Id;
        trans.TREX1__Public_Visibility__c = true;
        trans.TREX1__Status__c = TRANSACTION_STATUS_CLOSE;
        insert trans;

        Attachment attach = new Attachment();   	
    	attach.Name = TRANSACTION_RECEIPT_NAME;
    	Blob bodyBlob = Blob.valueOf('Receipt Attachment Body');
    	attach.body = bodyBlob;
        attach.parentId = trans.id;
        insert attach;

        return trans;
    }

    /**
     * Create a transaction for a contact in a draft status
     * @param Contact transaction contact
     * @return TREX1__Transaction__c Transaction
     */

     public static TREX1__Transaction__c createDraftTransaction(
        Contact contact
    ) {
        if (standardTransactionRecTypeId == null) {
            standardTransactionRecTypeId = Schema.SObjectType.TREX1__Transaction__c.getRecordTypeInfosByDeveloperName().get('Standard').getRecordTypeId();
        }

        TREX1__Transaction__c trans = new TREX1__Transaction__c();
        trans.RecordTypeId = standardTransactionRecTypeId;
        trans.TREX1__Account__c = contact.AccountId;
        trans.TREX1__Contact__c = contact.Id;
        trans.TREX1__Public_Visibility__c = true;
        trans.TREX1__Status__c = TRANSACTION_STATUS_DRAFT;
        insert trans;

        Attachment attach = new Attachment();   	
    	attach.Name = TRANSACTION_RECEIPT_NAME;
    	Blob bodyBlob = Blob.valueOf('Receipt Attachment Body');
    	attach.body = bodyBlob;
        attach.parentId = trans.id;
        insert attach;

        return trans;
    }

    /**
     * Create a manual adjustment transaction for a contact and account, complete with 
     * transaction line items, accounting events and journal entries. All manual adjustments
     * use accounts receivable as one side of the adjustment. Provide the other gl code to
     * adjust and whether that account should be debited or credited.
     * @param Contact transaction contact
     * @param Decimal transaction amount
     * @param String gl code to adjust
     * @param String adjustment type - 'Debit' or 'Credit'
     * @return TREX1__Transaction__c Transaction
     */

    public static TREX1__Transaction__c createManualAdjustmentTransaction(
        Contact contact,
        Decimal amount,
        String glCode,
        String adjustmentType
    ) {
        if (standardTransactionRecTypeId == null) {
            standardTransactionRecTypeId = Schema.SObjectType.TREX1__Transaction__c.getRecordTypeInfosByDeveloperName().get('Standard').getRecordTypeId();
        }

        // Transaction
        TREX1__Transaction__c trans = new TREX1__Transaction__c();
        trans.RecordTypeId = standardTransactionRecTypeId;
        trans.TREX1__Account__c = contact.AccountId;
        trans.TREX1__Contact__c = contact.Id;
        trans.TREX1__Public_Visibility__c = true;
        trans.TREX1__Status__c = TRANSACTION_STATUS_DRAFT;
        insert trans;

        // Transaction line item
        TREX1__Transaction_Line_Item__c tli = createManualAdjustmentTLI(trans, amount);
        insert tli;
        
        // Accounting event
        TREX1__Accounting_Event__c ae = createManualAdjustmentAccountingEvent(trans, tli, amount);
        insert ae;

        // Journal entries
        List<TREX1__Journal_Entry__c> lstJEs = createManualAdjustmentJournalEntries(
            ae,
            glCode,
            adjustmentType
        );
        insert lstJEs;

        return trans;
    }


    /***********************************
     * Transaction Line Items (TREX1)
     ***********************************/

    public static TREX1__Transaction_Line_Item__c createManualAdjustmentTLI(
        TREX1__Transaction__c trans,
        Decimal amount
    ) {
        if (manualAdjustmentTLIRecTypeId == null) {
            manualAdjustmentTLIRecTypeId = Schema.SObjectType.TREX1__Transaction_Line_Item__c.getRecordTypeInfosByDeveloperName().get('Manual_Adjustment').getRecordTypeId();
        }

        TREX1__Transaction_Line_Item__c tli = new TREX1__Transaction_Line_Item__c(
            RecordTypeId = manualAdjustmentTLIRecTypeId,
            TREX1__Transaction__c = trans.Id,
            TREX1__Contact__c = trans.TREX1__Contact__c,
            TREX1__Transaction_Contact__c = trans.TREX1__Contact__c,
            TREX1__Account__c = trans.TREX1__Account__c,
            TREX1__Initial_Fee_Amount__c = amount,
            TREX1__Deferred_Revenue_Recognition_Finished__c = true,
            TREX1__Description__c = 'Test adjustment',
            TREX1__Effective_Date__c = Date.today(),
            TREX1__Event_Type__c = TLI_EVENT_TYPE_MANUAL_ADJUSTMENT,
            TREX1__Net_Price__c = amount,
            TREX1__Status__c = TLI_STATUS_DRAFT,
            TREX1__Type__c = TLI_TYPE,
            TREX1__tli_Global_Billing_Group__c = getGlobalBillingGroupId(),
            TREX1__On_Close_Actions__c = 'No Action'
        );
        return tli;
    }


    /***********************************
     * Users
     ***********************************/

    /**
     * Create external users for a list of contacts
     * No DML - returns unsaved list of sObjects
     * @param List<Contact> Parent contacts for created users
     */

    public static List<User> createExternalUsers(
        List<Contact> lstParentContacts
    ) {
        List<User> lstUsers = new List<User>();
        for (Contact ct : lstParentContacts) {
            User u = ExternalUserUtilities.getUserWithDefaults();
            u.ContactId           = ct.Id;
            u.Username            = ct.Email;
            u.Email               = ct.Email;
            u.FirstName           = ct.FirstName;
            u.LastName            = ct.LastName;
            u.Alias               = ExternalUserUtilities.getAliasFromName(ct.FirstName, ct.LastName);
            u.CommunityNickname   = ExternalUserUtilities.getNicknameFromUsername(ct.Email);
            lstUsers.add(u);
        }
        return lstUsers;
    }

    /**
     * Create internal standard user
     * No DML - returns unsaved list of sObjects
     */

    public static User createStandardUser() {
        User u = ExternalUserUtilities.getUserWithDefaults();
        u.Username  = STANDARD_USER_USERNAME;
        u.Email     = STANDARD_USER_EMAIL;
        u.FirstName = STANDARD_USER_FIRSTNAME;
        u.LastName  = STANDARD_USER_LASTNAME;
        u.Alias     = STANDARD_USER_ALIAS;
        u.CommunityNickname = STANDARD_USER_NICKNAME;
        return u;
    }

    /**
     * Create internal standard user
     * No DML - returns unsaved sObject
     */

    public static User createStandardInternalUser() {

        Profile profile = [SELECT Id FROM Profile WHERE Name = :STANDARD_USER_PROFILE_NAME LIMIT 1];

        User u = new User();
        u.IsActive          = true;
        u.ProfileId         = profile.Id;
        u.TimeZoneSidKey    = UserInfo.getTimeZone().toString();
        u.LocaleSidKey      = UserInfo.getLocale();
        u.LanguageLocaleKey = UserInfo.getLocale();
        u.EmailEncodingKey  = EMAIL_ENCODING_KEY;
        u.Username          = STANDARD_USER_USERNAME;
        u.Email             = STANDARD_USER_EMAIL;
        u.FirstName         = STANDARD_USER_FIRSTNAME;
        u.LastName          = STANDARD_USER_LASTNAME;
        u.Alias             = STANDARD_USER_ALIAS;
        return u;

    }


}