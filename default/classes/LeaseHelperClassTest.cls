@isTest
public class LeaseHelperClassTest {
    
    @isTest
    public static void testGetLeaseData(){
        
        Tenant__c ten = new Tenant__c(Name ='Jim', Phone_Number__c ='98878734345', Email__c ='jim@example.com');
		insert ten;
        
        Property__c prop = new Property__c(Name = 'Home', Type__c ='Residential', Furnishing_Status__c = 'Semi-Furnished', Status__c = 'Occupied', 
                                           Image__c = '<p><img src="https://image.jpg"></img></p>', Rent__c = 34300, Description__c = 'House.', 
                                           Address__Street__s = 'Electronic City Elevated Expressway', Address__City__s = 'Bangalore', 
                                           Address__PostalCode__s = '583105', Address__StateCode__s = 'KA', Address__CountryCode__s = 'IN', Tenant__c = ten.Id);
        insert prop;
        
        Test.setMock(HttpCalloutMock.class, new GeolocationCalloutMock());
        
        Lease_Agreement__c la  = [Select Id from Lease_Agreement__c];
        
        Test.startTest();
        
        String result = LeaseHelperClass.getLeaseData(la.Id);
        Map<String,Object> resultData  = (Map<String,Object>) JSON.deserializeUntyped(result);
        Assert.areEqual('Home',resultData.get('propertyName'));
        Assert.areEqual('Jim',resultData.get('tenantName'));
        Assert.areEqual(34300,resultData.get('agreedMonthlyRent'));
        Assert.areEqual(String.valueOf(Date.today()),resultData.get('startDate'));
        Assert.areEqual(String.valueOf(Date.today().addyears(1)),resultData.get('endDate'));
        Test.stopTest();
    }   
}