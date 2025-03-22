trigger MaintenanceRequestTrigger on Maintenance_Request__c (before insert) {

    if(Trigger.isBefore){
        if(Trigger.isInsert){
            MaintenancerequestTriggerHelper.assignVendor(Trigger.new);
        }
    }
}