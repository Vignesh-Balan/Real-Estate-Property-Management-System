trigger PropertyTrigger on Property__c (before insert, after insert, after update) {
	
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            PropertyValidateHelperClass.validateAddressImage(Trigger.new);
        }
    }
    else if(Trigger.isAfter){
        	if(Trigger.isInsert){
                //updates geo location in child object
           		Id queueId = System.enqueueJob(new PropertyGeolocationClass(Trigger.new));
        	}
        PropertyTenantLeaseHelper.createLease(Trigger.newMap);
    }
}