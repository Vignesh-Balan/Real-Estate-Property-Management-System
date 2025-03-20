public class PropertyListClass {
	
    @AuraEnabled
    public static String getPropertyList(Integer startNumber, Decimal inputPrice, String inputStatus, String inputFurnishingStatus, Decimal inputLong, Decimal inputLat){
        
        String query ='Select Id, Name, Rent__c, Type__c, Furnishing_Status__c from Property__c where Id != Null';
        
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
        
        Map<String,Object>  propMap = new Map<String,Object>();
        propMap.put('result',propList);
        
        String resultJson = JSON.serialize(propMap);
        return resultJson;
    }
}