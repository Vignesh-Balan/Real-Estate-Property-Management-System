@istest
public class PropertyListClassTest {

    @isTest
    public static void testGetPropertyList(){
        
        Tenant__c ten = new Tenant__c(Name ='Jim', Phone_Number__c ='98878734345', Email__c ='jim@example.com');
		insert ten;
        
        Property__c propNew = new Property__c(Name = 'Home', Type__c ='Residential', Furnishing_Status__c = 'Semi-Furnished', Status__c = 'Occupied', 
                                           Image__c = '<p><img src="https://image.jpg"></img></p>', Rent__c = 34300, Description__c = 'House.', 
                                           Address__Street__s = 'Electronic City Elevated Expressway', Address__City__s = 'Bangalore', 
                                           Address__PostalCode__s = '583105', Address__StateCode__s = 'KA', Address__CountryCode__s = 'IN', Tenant__c = ten.Id);
        insert propNew;
        
        Test.setMock(HttpCalloutMock.class, new GeolocationCalloutMock());
        Test.startTest();
        String result = PropertyListClass.getPropertyList(0, 40000.0, 'Occupied' , 'Semi-Furnished', 0.0, 0.0);
        List<Object> propList = (List<Object>) JSON.deserializeUntyped(result);
        Map<String,Object> prop = (Map<String,Object>) propList[0];
        Assert.areEqual('Home',prop.get('name'));
       Assert.areEqual(34300,prop.get('price'));
        Assert.areEqual('Occupied',prop.get('status'));
        Assert.areEqual('Semi-Furnished',prop.get('furnishingStatus')); 
        Test.stopTest();
    }
}