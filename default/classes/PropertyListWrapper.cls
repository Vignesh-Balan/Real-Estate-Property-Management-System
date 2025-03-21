public class PropertyListWrapper {
	
    String Id;
    String name;
    Decimal price;
    String status;
    String furnishingStatus;
    String address;
    String propType;
    
    public PropertyListWrapper(String Id, String name, Decimal price, String status, String furnishingStatus, String address,String propType){
        this.Id = Id;
        this.name = name;
        this.price = price;
        this.status = status;
        this.furnishingStatus = furnishingStatus;
        this.address = address;
        this.propType = propType;
    }
}