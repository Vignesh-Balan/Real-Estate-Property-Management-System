public with sharing class PropertyListClass {
	
    @AuraEnabled
    public static String getPropertyList(Integer startNumber, Decimal inputPrice, String inputStatus, String inputFurnishingStatus, Decimal inputLong, Decimal inputLat){
        
        String query ='Select Id, Name, Address__Street__s, Address__City__s, Address__PostalCode__s, Address__StateCode__s, Address__CountryCode__s, Status__c, Rent__c, Type__c, Furnishing_Status__c from Property__c where Id != Null';
        
        inputStatus = String.escapeSingleQuotes(inputStatus);
        inputFurnishingStatus = String.escapeSingleQuotes(inputFurnishingStatus);
        
        if(inputPrice != 0.0){
            query = query + ' and Rent__c <= '+inputPrice;
        }
        
        if(inputStatus != ''){
            query = query + ' and Status__c = \''+inputStatus +'\'';
        }
        
        if(inputFurnishingStatus != ''){
             query = query + ' and Furnishing_Status__c = \''+inputFurnishingStatus +'\'';
        }
        
        Integer pagesize = startNumber + 25;
        query=query + ' Limit '+ pagesize + ' Offset '+ startNumber;
        
        List<Property__c> propList = Database.query(query);
        
        if(propList.isEmpty()){
            return Null;
        }
        
        List<PropertyListWrapper> resultList = new List<PropertyListWrapper>();
        
        for(Property__c prop: propList){
            String address = prop.Address__Street__s +' '+prop.Address__City__s+' '+prop.Address__PostalCode__s+' '+ 
                			 prop.Address__StateCode__s +' '+ prop.Address__CountryCode__s;
                
            PropertyListWrapper propWrap = new PropertyListWrapper(prop.Id,prop.Name,prop.Rent__c,prop.Status__c,prop.Furnishing_Status__c,address,prop.Type__c);
            resultList.add(propWrap);
        }

        
        String resultJson = JSON.serialize(resultList);
        return resultJson;
    }
}