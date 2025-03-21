public class PropertyListWrapper {
	
    String name;
    Decimal price;
    String status;
    String furnishingStatus;
    String Address;
    String propType;
    
    public PropertyListWrapper(String name, Decimal price, String status, String furnishingStatus, String Address,String propType){
        this.name = name;
        this.price = price;
        this.status = status;
        this.furnishingStatus = furnishingStatus;
        this.Address = Address;
        this.propType = propType;
    }
}