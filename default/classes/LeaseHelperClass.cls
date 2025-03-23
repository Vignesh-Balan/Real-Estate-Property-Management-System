public with sharing class LeaseHelperClass {

    @AuraEnabled
    public static String getLeaseData(Id recordId){
        List<Lease_Agreement__c> leaseList = [Select Tenant__r.Name, Property__r.Name, Name, Agreed_Monthly_Rent__c, 
                                              Start_Date__c, End_Date__c FROM Lease_Agreement__c where Id = :recordId];
        
        if(leaseList.isEmpty()){
            return null;
        }
        
        Map<String,Object> leaseMap =  new Map<String,Object>();
        leaseMap.put('propertyName',leaseList[0].Property__r.Name);
        leaseMap.put('tenantName',leaseList[0].Tenant__r.Name);
        leaseMap.put('leaseName',leaseList[0].Name);
        leaseMap.put('agreedMonthlyRent',leaseList[0].Agreed_Monthly_Rent__c);
        leaseMap.put('startDate',leaseList[0].Start_Date__c);
        leaseMap.put('endDate',leaseList[0].End_Date__c);
        
        return JSON.serialize(leaseMap);
        
    }
}