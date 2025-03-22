import { LightningElement, wire } from 'lwc';
import getPropertyList from '@salesforce/apex/PropertyListClass.getPropertyList';
import { getPicklistValues} from 'lightning/uiObjectInfoApi';
import STATUS_FIELD from '@salesforce/schema/Property__c.Status__c';
import FURNISHING_STATUS_FIELD from '@salesforce/schema/Property__c.Furnishing_Status__c';

export default class CustomPropertyList extends LightningElement {

    propList;
    isDataLoaded = false;
    message ="";

    price = 0.0;
    status = "";
    furnishingStatus = "";
    lat = 0.0;
    log = 0.0;
    statusOptions;
    furnishingStatusOptions;
    pageNumber = 1;
    startNumber =0;

    @wire(getPicklistValues,{recordTypeId:"012000000000000AAA", fieldApiName: STATUS_FIELD})
    getPicklistStatus({data,error}){
        if(data){
            this.statusOptions = data.values;
        }else {
            console.log('Status picklist error : ' +error);
        }
    }

    @wire(getPicklistValues,{recordTypeId:"012000000000000AAA", fieldApiName: FURNISHING_STATUS_FIELD})
    getPicklistFurnishingStatus({data,error}){
        if(data){
            this.furnishingStatusOptions = data.values;
        }else {
            console.log('Furnishin Status picklist error : ' +error);
        }
    }

    handlePrice(event){
        this.price = event.target.value;
        
        if(this.price == "" || this.price == null || this.price == undefined){
            this.price = 0.0;
        }
        console.log('price ' + this.price);
    }

    handleStatusChange(event){
        this.status = event.target.value;
    }

    handleFurnishStatusChange(event){
        this.furnishingStatus = event.target.value;
    }
    handleLat(event){
        this.lat = event.target.value;
    }

    handleLog(event){
        this.log = event.target.value;
    }

    handleClick(){
        this.isDataLoaded = false;
        this.message = "";
        this.startNumber = 0;
        this.pageNumber = 1;
        this.isNewClicked=false;
        this.handlePropData();    
    }

    handlePrevious(){
        if(this.pageNumber !== 1){
            this.isDataLoaded = false;
            this.message = "";
            this.pageNumber -= 1;
            this.startNumber -= 25;
            this.handlePropData();
        }
    }

    handleNext(){
        this.isDataLoaded = false;
        this.message = "";
        this.startNumber += 25;
        this.pageNumber += 1;
        this.handlePropData();
    }

    handlePropData(){
        getPropertyList({
            startNumber:this.startNumber,
            inputPrice:this.price,
            inputStatus:this.status,
            inputFurnishingStatus:this.furnishingStatus,
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

    isNewClicked = false;

    fields=['Name', 'Type__c', 'Furnishing_Status__c', 'Status__c', 'Image__c', 'Rent__c', 'Address__Street__s', 'Address__City__s', 
            'Address__PostalCode__s', 'Address__StateCode__s', 'Address__CountryCode__s', 'Description__c' ];

    handleNewClick(){
        this.isDataLoaded = false;
        this.message = "";
        this.isNewClicked = true;
    }
}