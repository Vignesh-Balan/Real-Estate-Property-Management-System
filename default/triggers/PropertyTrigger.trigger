trigger PropertyTrigger on Property__c (before insert, after insert) {
	
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            PropertyValidateHelperClass.validateAddressImage(Trigger.new);
        }
    }
    else if(Trigger.isAfter){
        	if(Trigger.isInsert){
           		Id queueId = System.enqueueJob(new PropertyGeolocationClass(Trigger.new));
        }
    }
}