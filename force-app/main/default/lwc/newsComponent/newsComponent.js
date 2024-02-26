import { LightningElement, track } from 'lwc';
import getNewsDataFromService from '@salesforce/apex/NewsController.getNewsDataFromService';

export default class NewsComponent extends LightningElement {
    @track result = [];

    connectedCallback() {
        this.fetchNews();
    }

    async fetchNews() {
        try {
            const response = await getNewsDataFromService();
            console.log('Raw response:', response);
            if (response && response.articles) {
                this.formatNewsData(response.articles);
            } else {
                throw new Error('Invalid response format');
            }
        } catch (error) {
            console.error('Error fetching news:', error);
        }
    }

    async formatNewsData(articles) {
        this.result = [];
        for (let index = 0; index < articles.length; index++) {
            const article = articles[index];
            const id = `new_${index + 1}`;
            const name = article.source?.name || 'Unknown Source';
            const urlToImage = article.urlToImage || '';
            try {
                const blobUrl = await this.convertToBlob(urlToImage);
                this.result.push({ ...article, id, name, urlToImage, blobUrl });
            } catch (error) {
                console.error('Error converting to blob:', error);
                this.result.push({ ...article, id, name, urlToImage, blobUrl: '' });
            }
        }
        console.log('Formatted Result:', this.result);
    }

    async convertToBlob(urlToImage) {
        if (!urlToImage) return ''; // Return empty string if URL is not provided
        try {
            const response = await fetch(urlToImage);
            const blob = await response.blob();
            return URL.createObjectURL(blob);
        } catch (error) {
            console.error('Error converting to blob:', error);
            throw error; // Rethrow error for the caller to handle
        }
    }
}
