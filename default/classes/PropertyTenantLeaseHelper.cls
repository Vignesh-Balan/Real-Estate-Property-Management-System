public class PropertyTenantLeaseHelper {

    public static void createLease(Map<Id,Property__c> newPropMap){
        
        
        //check if tenant is created and if persent create lease
        List<Property__c> propList = [Select Id, Rent__c, Tenant__c, (Select Id from Lease_Agreements__r) lease from Property__c where Id in :newPropMap.keySet()];
		
        List<Lease_Agreement__c> listOfNewLease = new List<Lease_Agreement__c>();
        for(Property__c prop: newPropMap.values()){
            //this condition checks for if the tenant value is present and there is no lease agreement already in the property
            if(prop.Tenant__c != null && prop.Lease_Agreements__r.isEmpty()){               
                Lease_Agreement__c la = new Lease_Agreement__c( Property__c = prop.Id,
                                                             Tenant__c = prop.Tenant__c,
                                                             Start_Date__c = Date.today(),
                                                             End_Date__c = Date.today().addyears(1),
                                                             Agreed_Monthly_Rent__c = prop.Rent__c);
                listOfNewLease.add(la);
            }
        }
        
        List<Database.SaveResult> databaseResult = Database.insert(listOfNewLease);
        
        for(Database.SaveResult updateResult: databaseResult){
            if(updateResult.isSuccess()){
                System.debug('Record Inserted Successfully');
            }
            else{
                for(Database.Error error: updateResult.getErrors()){
                    System.debug('Error: '+ error.getMessage());
                }
            }
        }
    }
}