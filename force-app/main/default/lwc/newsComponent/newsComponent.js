import { LightningElement } from 'lwc';
import getNewsDataFromService from '@salesforce/apex/NewsController.getNewsDataFromService' ;
export default class NewsComponent extends LightningElement {
    
    connectedCallback(){
        this.fetchNews();
    }
    fetchNews(){
        getNewsDataFromService().then(response=>{
            console.log(response);
        }).catch(error=>{
            cpnsole.error(error);
        })
    }
}