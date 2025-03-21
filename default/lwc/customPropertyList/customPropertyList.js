import { LightningElement } from 'lwc';
import getPropertyList from '@salesforce/apex/PropertyListClass.getPropertyList';

export default class CustomPropertyList extends LightningElement {

    propList;
    isDataLoaded = false;
    message ="";

    handleClick(){
        this.isDataLoaded = false;
        this.message = "";
        getPropertyList({
            startNumber:0,
            inputPrice:0.0,
            inputStatus:"",
            inputFurnishingStatus:"",
            inputLong:0.0,
            inputLat:0.0
        }).then( result => {
            this.propList = JSON.parse(result);
            if(this.propList == null){
                this.message = "Reached end there is no property with the mentioned category."
            }
            else{
                console.log('prop List' + this.propList);
                this.isDataLoaded = true;
            }
            
        }).catch( error => {
            console.log('Error Occured '+ error);
        });
    }
}