public class MaintenancerequestTriggerHelper {
    
    public static Map<Id,Integer> requestNumberOfVendor = new Map<Id,Integer>();
     public static final Integer MAX_VALUE = 2147483647;
    
    public static void assignVendor(List<Maintenance_Request__c> newRequest){
        
        List<Vendor__c> vendorList = [SELECT Id, Name, Phone_Number__c, Email__c, 
                                      (SELECT Id FROM Maintenance_Requests__r where status__c in ('Open','In progress')) 
                                      FROM Vendor__c];

            for(Vendor__c ven: vendorList){
                requestNumberOfVendor.put(ven.Id,ven.Maintenance_Requests__r.size());
            }
        
        for(Maintenance_Request__c mar: newRequest){
            Id vendorId = findVendorWithMin(requestNumberOfVendor);
            mar.Vendor__c= vendorId;
        }
        
        
    }
    
    public static Id findVendorWithMin(Map<Id,Integer> requestNumberOfVendor){
        Id minId;
        Integer minRequest = MAX_VALUE;
        for(Id venId: requestNumberOfVendor.keySet()){
            if(requestNumberOfVendor.get(venId) < minRequest){
                minrequest = requestNumberOfVendor.get(venId);
                minId = venId;
            }
        }
        requestNumberOfVendor.put(minId,(requestNumberOfVendor.get(minId)+1));
        return minId;
    }
    
}