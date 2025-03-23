@isTest
public class PropertyValidateHelperClassTest {

    @isTest
    public static void testPropertyValidateHelperClass(){
        
        Test.setMock(HttpCalloutMock.class, new GeolocationCalloutMock());
        
        Property__c prop1 = new Property__c(Name = 'Home', Type__c ='Residential', Furnishing_Status__c = 'Semi-Furnished', Status__c = 'Occupied', 
                                               Image__c = '<p><img src="https://image.jpg"></img></p>', Rent__c = 34300, Description__c = 'House.', 
                                               Address__Street__s = 'Electronic City Elevated Expressway', Address__City__s = null, 
                                               Address__PostalCode__s = '583105', Address__StateCode__s = 'KA', Address__CountryCode__s = 'IN');
        
        Property__c prop2 = new Property__c(Name = 'Home', Type__c ='Residential', Furnishing_Status__c = 'Semi-Furnished', Status__c = 'Occupied', 
                                               Image__c = '<p><img src="https://image.jpg"></img></p>', Rent__c = 34300, Description__c = 'House.', 
                                               Address__Street__s = 'Electronic City Elevated Expressway', Address__City__s = 'Bangalore', 
                                               Address__PostalCode__s = null, Address__StateCode__s = 'KA', Address__CountryCode__s = 'IN');
       
        Property__c prop3 = new Property__c(Name = 'Home', Type__c ='Residential', Furnishing_Status__c = 'Semi-Furnished', Status__c = 'Occupied', 
                                               Image__c = '<p><img src="https://image.jpg"></img></p>', Rent__c = 34300, Description__c = 'House.', 
                                               Address__Street__s = 'Electronic City Elevated Expressway', Address__City__s = 'Bangalore', 
                                               Address__PostalCode__s = '583105', Address__StateCode__s = null, Address__CountryCode__s = 'IN');
   
        Property__c prop4 = new Property__c(Name = 'Home', Type__c ='Residential', Furnishing_Status__c = 'Semi-Furnished', Status__c = 'Occupied', 
                                               Image__c = '<p><img src="https://image.jpg"></img></p>', Rent__c = 34300, Description__c = 'House.', 
                                               Address__Street__s = 'Electronic City Elevated Expressway', Address__City__s = 'Bangalore', 
                                               Address__PostalCode__s = '583105', Address__CountryCode__s = null, Address__StateCode__s = null);
   
        Property__c prop5 = new Property__c(Name = 'Home', Type__c ='Residential', Furnishing_Status__c = 'Semi-Furnished', Status__c = 'Occupied', 
                                               Image__c = null, Rent__c = 34300, Description__c = 'House.', 
                                               Address__Street__s = 'Electronic City Elevated Expressway', Address__City__s = 'Bangalore', 
                                               Address__PostalCode__s = '583105', Address__StateCode__s = 'KA', Address__CountryCode__s = 'IN');
        

	
		Test.startTest();
            try {
                insert prop1;
            } catch(DmlException e) {
                Assert.isTrue(e.getMessage().contains('City cannot be empty'));
            }
        
      		try {
                insert prop2;
            } catch(DmlException e) {
                Assert.isTrue(e.getMessage().contains('Postal Code cannot be empty'));
            }
        	
        	try {
                insert prop3;
            } catch(DmlException e) {
                Assert.isTrue(e.getMessage().contains('State cannot be empty'));
            }
        	
        	try {
                insert prop4;
            } catch(DmlException e) {
                Assert.isTrue(e.getMessage().contains('Country cannot be empty'));
            }
        	
        	try {
                insert prop5;
            } catch(DmlException e) {
                Assert.isTrue(e.getMessage().contains('Add an image of the property'));
            }
        	
		Test.stopTest();        
    }
}