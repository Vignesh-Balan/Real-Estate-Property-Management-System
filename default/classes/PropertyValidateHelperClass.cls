public class PropertyValidateHelperClass {
	
    public static void validateAddressImage(List<Property__c> listOfNewProperty){
        
        //Using single bulkified for loop to reduce CPU time and enhance performance
        for(Property__c prop: listOfNewProperty){
            //Validating the address field.
            if(prop.Address__City__s == Null){
                prop.Address__City__s.addError('City cannot be empty');
            }
            
            if(prop.Address__PostalCode__s == Null){
                prop.Address__PostalCode__s.addError('Postal Code cannot be empty');
            }
            
            if(prop.Address__CountryCode__s == Null){
                prop.Address__CountryCode__s.addError('Country cannot be empty');
            }
            
            if(prop.Address__StateCode__s == Null){
                prop.Address__StateCode__s.addError('State cannot be empty');
            }
            
            if(prop.Image__c != Null){
                
                String imageCheck = prop.Image__c.substringBetween('<img','img>');
                
                if(imageCheck == null){
                    prop.Image__c.addError('Add an image of the property');
                }
            }else{
                prop.Image__c.addError('Add an image of the property');
            } 
        }
    }
    
}