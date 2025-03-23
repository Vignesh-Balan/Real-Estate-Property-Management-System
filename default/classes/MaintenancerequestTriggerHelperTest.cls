@isTest
public class MaintenancerequestTriggerHelperTest {

	@isTest
    public static void testAssign(){
        
        Test.setMock(HttpCalloutMock.class, new GeolocationCalloutMock());
        
        Property__c prop1 = new Property__c(Name = 'Home', Type__c ='Residential', Furnishing_Status__c = 'Semi-Furnished', Status__c = 'Occupied', 
                                           Image__c = '<p><img src="https://image.jpg"></img></p>', Rent__c = 34300, Description__c = 'House.', 
                                           Address__Street__s = 'Electronic City Elevated Expressway', Address__City__s = 'Bangalore', 
                                           Address__PostalCode__s = '583105', Address__StateCode__s = 'KA', Address__CountryCode__s = 'IN');
        insert prop1;
        
        Property__c prop2 = new Property__c(Name = 'Home', Type__c ='Residential', Furnishing_Status__c = 'Semi-Furnished', Status__c = 'Occupied', 
                                           Image__c = '<p><img src="https://image.jpg"></img></p>', Rent__c = 34300, Description__c = 'House.', 
                                           Address__Street__s = 'Electronic City Elevated Expressway', Address__City__s = 'Bangalore', 
                                           Address__PostalCode__s = '583105', Address__StateCode__s = 'KA', Address__CountryCode__s = 'IN');
        insert prop2;
        
        Vendor__c ven1 = new Vendor__c(Name = 'Jim', Email__c = 'jim@example.com');
        insert ven1;
        
        Maintenance_Request__c mar1 = new Maintenance_Request__c(Status__c = 'Open', Description__c = 'Water pipe is broken', Property__c = prop1.Id);
        insert mar1;
        
        Vendor__c ven2 = new Vendor__c(Name = 'Tim', Email__c = 'Tim@example.com');
        insert ven2;
        
        Maintenance_Request__c mar2 = new Maintenance_Request__c(Status__c = 'Open', Description__c = 'Water pipe is broken', Property__c = prop2.Id);
        insert mar2;
        
        Property__c prop = [SELECT Id, (Select Vendor__r.Name from Maintenance_Requests__r)FROM Property__c where Id = :prop2.Id ];
		Assert.areEqual('Tim',prop.Maintenance_Requests__r[0].Vendor__r.Name);        
        
    }    
}