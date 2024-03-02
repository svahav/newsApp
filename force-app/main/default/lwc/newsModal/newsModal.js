import { LightningElement, api } from 'lwc';

export default class NewsModal extends LightningElement {
    @api selectedNews;

    closeModal() {
        const closeEvent = new CustomEvent('closemodal');
        this.dispatchEvent(closeEvent);
    }
    
    get modalClass() {
        return `slds-modal ${this.selectedNews ? 'slds-fade-in-open' : ''}`;
    }

    get modalBackdropClass() {
        return this.selectedNews ? 'slds-backdrop slds-backdrop_open' : 'slds-backdrop';
    }

}
