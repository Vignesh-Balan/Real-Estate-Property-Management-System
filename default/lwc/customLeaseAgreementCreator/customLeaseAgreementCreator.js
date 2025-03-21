import { LightningElement, api } from "lwc";
import getLeaseData from '@salesforce/apex/LeaseHelperClass.getLeaseData';
import jsPDFResource from '@salesforce/resourceUrl/jsPDF';  // Import Static Resource
import { loadScript } from 'lightning/platformResourceLoader';

export default class CustomLeaseAgreementCreator extends LightningElement {


    @api recordId;
    leaseData;
    inputText;
    propertyName;
    tenantName;
    leaseName;
    agreedMonthlyRent;
    startDate;
    endDate;

    connectedCallback(){
        getLeaseData({recordId:this.recordId
        }).then(result => {
            this.leaseData =JSON.parse(result);
            this.propertyName = this.leaseData.propertyName;
            this.tenantName = this.leaseData.tenantName;
            this.leaseName = this.leaseData.leaseName;
            this.agreedMonthlyRent = this.leaseData.agreedMonthlyRent;
            this.startDate = this.leaseData.startDate;
            this.endDate = this.leaseData.endDate;
        }).catch( error => {
            console.log('Error occured  : '+error);
        });
    }

    handleInputText(event){
        this.inputText = event.target.value;
    }

    jsPDFInitialized = false;

    renderedCallback() {
        if (this.jsPDFInitialized) {
            return;
        }
        this.jsPDFInitialized = true;

        // Load jsPDF library
        loadScript(this, jsPDFResource)
            .then(() => {
                console.log('jsPDF loaded successfully.');
            })
            .catch(error => {
                console.error('Failed to load jsPDF:', error);
            });
    }

    generatePDF() {
        if (window.jspdf) {
            const { jsPDF } = window.jspdf;

            const doc = new jsPDF();
            doc.setFontSize(12);
            doc.text('Lease Agreement - '+ this.leaseName, 40, 10);

            doc.setFontSize(10);
            doc.text('Property Name: '+ this.propertyName, 10, 20);
            doc.text('Tenant Name: '+ this.tenantName, 10, 30);
            doc.text('Agreed Monthly Rent: '+ this.agreedMonthlyRent, 10, 40);
            doc.text('Start Date: '+ this.startDate, 10, 50);
            doc.text('End Date: '+ this.endDate, 10, 60);

            const wrappedText = doc.splitTextToSize(this.inputText, 160);
            doc.text(wrappedText, 10, 80);

            doc.setFontSize(10);
            doc.text('Tenant Signature ', 10, 240);
            doc.text('Property Owner Signature ', 150, 240);
            doc.save('Lease Agreement - '+ this.leaseName +'.pdf');
        } else {
            console.error('jsPDF is not loaded.');
        }
    }
}