public class PropertyGeolocationClass implements Queueable, Database.AllowsCallouts {
    
    public  List<Property__c> propertyList = new List<Property__c>();
    
    public PropertyGeolocationClass(List<Property__c> propertyList){
        this.propertyList = propertyList;
    }
    
    public  void execute(QueueableContext qc){
        
        Map<String,String> countryStateCode = new Map<String,String>{'IN' => 'India', 'TN' => 'Tamil Nadu',
            'AP' => 'Andhra Pradesh',	'AR' => 'Arunachal Pradesh',	'AS' => 'Assam',	'BR' => 'Bihar',	'CG' => 'Chhattisgarh',	'CH' => 'Chandigarh',	'DD' => 'Dadra and Nagar Haveli and Daman and Diu',	'DL' => 'Delhi',	'GA' => 'Goa',
            'GJ' => 'Gujarat',	'HR' => 'Haryana',	'HP' => 'Himachal Pradesh',	'JK' => 'Jammu and Kashmir',	'JH' => 'Jharkhand',	'KA' => 'Karnataka',	'KL' => 'Kerala',	'LA' => 'Ladakh',	'LD' => 'Lakshadweep',
            'MP' => 'Madhya Pradesh',	'MH' => 'Maharashtra',	'MN' => 'Manipur',	'ML' => 'Meghalaya',	'MZ' => 'Mizoram',	'NL' => 'Nagaland',	'OD' => 'Odisha',	'PY' => 'Puducherry',	'PB' => 'Punjab',
            'RJ' => 'Rajasthan',	'SK' => 'Sikkim',	'TN' => 'Tamil Nadu',	'TG' => 'Telangana',	'TR' => 'Tripura',	'UK' => 'Uttarakhand',	'UP' => 'Uttar Pradesh',	'WB' => 'West Bengal',	'AN' => 'Andaman and Nicobar'};
                
                Http http = new Http();
        HttpRequest request = new HttpRequest();
        String apiKey = 'pk.23f4a22869e248404782f0079ca172a6';
        
        List<Geolocation__c> newGeoList =   new List<Geolocation__c>();
        for(Property__c prop: propertyList){
            String address = prop.Address__Street__s + ', ' + prop.Address__City__s + ' ' + prop.Address__PostalCode__s + ', ' + 
                countryStateCode.get(prop.Address__StateCode__s) + ', ' + countryStateCode.get(prop.Address__CountryCode__s);
            
            address = address.replaceAll(',' , '%2C');
            address = address.replaceAll(' ' , '%20');
            
            String urlAddress = 'https://us1.locationiq.com/v1/search?key='+ apikey + '&q=' + 
                address + '&format=json&';
            request.setEndpoint(urlAddress);
            request.setMethod('GET');
            HttpResponse response = http.send(request);
            
            if(response.getStatus() == 'Ok'){
                List<Object> resultJSON = (List<Object>) JSON.deserializeUntyped(response.getBody());
                Map<String,Object> resultMap = (Map<String,Object>) resultJSON[0];
                
                Geolocation__c gloc = new Geolocation__c( Property__c = prop.Id,
                                                         Name= prop.Name + 'Geo Location',
                                                         Property_Geolocation__Longitude__s = Decimal.valueOf((String)resultMap.get('lon')),
                                                         Property_Geolocation__Latitude__s  = Decimal.valueOf((String)resultMap.get('lat')) );
                
                newGeoList.add(gloc);              
            }
            else{
                System.debug(' error: ' + response.getBody());
            } 
        }
        
        List<Database.SaveResult> databaseResult = Database.insert(newGeoList);
        
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