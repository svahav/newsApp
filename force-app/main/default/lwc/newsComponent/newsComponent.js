import { LightningElement, track } from 'lwc';
import getNewsDataFromService from '@salesforce/apex/NewsController.getNewsDataFromService';

export default class NewsComponent extends LightningElement {
    @track result = [];

    connectedCallback() {
        this.fetchNews();
    }

    fetchNews() {
        getNewsDataFromService()
            .then(response => {
                console.log(response);
                this.formatNewsData(response.articles);
            })
            .catch(error => {
                console.error(error);
                debugger;
            });
    }

    formatNewsData(res) {
        this.result = res.map((item, index) => {
            let id = `new_${index + 1}`;
            let name = item.source.name;
            let urlToImage = item.urlToImage !== null ? item.urlToImage : ''; // Check if urlToImage is not null
         
            return { ...item, id, name };
        });
        console.log('Formatted Result:', this.result);
    }

}
