public with sharing class newsController {
    @AuraEnabled(cacheable=true)
    public static Map<String, Object> getNewsDataFromService() {
        NewsService newsService = new NewsService();
        return newsService.getNewsData();
    }
}