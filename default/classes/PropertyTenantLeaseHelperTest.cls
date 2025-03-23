@isTest
public class PropertyTenantLeaseHelperTest {

    @isTest
    public static void testCreateLease(){
        
        Tenant__c ten = new Tenant__c(Name ='Jim', Phone_Number__c ='98878734345', Email__c ='jim@example.com');
		insert ten;
        
        Property__c prop = new Property__c(Name = 'Home', Type__c ='Residential', Furnishing_Status__c = 'Semi-Furnished', Status__c = 'Occupied', 
                                           Image__c = '<p><img src="https://image.jpg"></img></p>', Rent__c = 34300, Description__c = 'House.', 
                                           Address__Street__s = 'Electronic City Elevated Expressway', Address__City__s = 'Bangalore', 
                                           Address__PostalCode__s = '583105', Address__StateCode__s = 'KA', Address__CountryCode__s = 'IN', Tenant__c = ten.Id);
        insert prop;
        
        Test.setMock(HttpCalloutMock.class, new GeolocationCalloutMock());
        
        Lease_Agreement__c la  = [SELECT Id, Name, Property__r.Name, Tenant__r.Name, Agreed_Monthly_Rent__c, Start_Date__c, End_Date__c FROM Lease_Agreement__c];
        
        Test.startTest();
        Assert.areEqual('Home',la.Property__r.Name);
        Assert.areEqual('Jim',la.Tenant__r.Name);
        Assert.areEqual(34300,la.Agreed_Monthly_Rent__c);
        Assert.areEqual(Date.today(),la.Start_Date__c);
        Assert.areEqual(Date.today().addyears(1),la.End_Date__c);
        Test.stopTest();
    }  
    
}