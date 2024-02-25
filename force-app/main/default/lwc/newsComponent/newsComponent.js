import { LightningElement } from 'lwc';
import getNewsData from '@salesforce/apex/NewsController.getNewsData' ;
export default class NewsComponent extends LightningElement {
    
    connectedCallback(){
        this.fetchNews();
    }
    fetchNews(){
        getNewsData().then(response=>{
            console.log(response);
        }).catch(error=>{
            cpnsole.error(error);
        })
    }
}