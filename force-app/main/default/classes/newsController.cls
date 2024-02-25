public with sharing class NewsController {
    @AuraEnabled(cacheable=true)
    public static Map<String, Object> getNewsData() {
        return NewsService.retrieveNews();
    }
}
