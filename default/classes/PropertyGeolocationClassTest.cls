@isTest
public class PropertyGeolocationClassTest {

    
    @IsTest
    private static void testQueueableClass() {
        
        Property__c prop = new Property__c(Name = 'Home', Type__c ='Residential', Furnishing_Status__c = 'Semi-Furnished', Status__c = 'Occupied', 
                                           Image__c = '<p><img src="https://image.jpg"></img></p>', Rent__c = 34300, Description__c = 'House.', 
                                           Address__Street__s = 'Electronic City Elevated Expressway', Address__City__s = 'Bangalore', 
                                           Address__PostalCode__s = '583105', Address__StateCode__s = 'KA', Address__CountryCode__s = 'IN');
        
        
        Test.setMock(HttpCalloutMock.class, new GeolocationCalloutMock());
        
        Test.startTest();
        insert prop;
        Test.stopTest();
        Geolocation__c geo = [SELECT Id, Property_Geolocation__Latitude__s, Property_Geolocation__Longitude__s FROM Geolocation__c];
        Assert.areEqual(geo.Property_Geolocation__Latitude__s,12.9767936);
        Assert.areEqual(geo.Property_Geolocation__Longitude__s,77.590082); 
    }
}