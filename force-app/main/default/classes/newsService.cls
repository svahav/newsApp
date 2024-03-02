public with sharing class NewsService {
    private static Map<String, Object> getNewsData() {
        HttpRequest httpRequest = new HttpRequest();
        httpRequest.setEndpoint('https://newsapi.org/v2/everything?q=apple&from=2024-02-25&to=2024-02-25&sortBy=popularity&apiKey=7b6f8c2f8884438dbb74fcc05b489aad');
        httpRequest.setMethod('GET');

        HttpResponse httpResponse;
        String strResponse;
        Map<String, Object> newsJsonData = new Map<String, Object>();

        try {
            Http http = new Http();
            httpResponse = http.send(httpRequest);

            if (httpResponse.getStatusCode() == 200) {
                strResponse = httpResponse.getBody();
                if (!String.isBlank(strResponse)) {
                    newsJsonData = (Map<String, Object>) JSON.deserializeUntyped(strResponse);
                    if (newsJsonData.containsKey('articles')) {
                        List<Object> articles = (List<Object>) newsJsonData.get('articles');
                        for (Object articleObj : articles) {
                            Map<String, Object> article = (Map<String, Object>) articleObj;
                            // Check if the 'urlToImage' key exists in the article, if not, set it to an empty string
                            if (!article.containsKey('urlToImage')) {
                                article.put('urlToImage', '');
                            }
                        }
                    }
                }
            } else {
                throw new CalloutException('HTTP Error: ' + httpResponse.getStatusCode() + ' ' + httpResponse.getStatus());
            }
        } catch (CalloutException ex) {
            throw ex; 
        } catch (Exception ex) {
            throw new CalloutException('An unexpected error occurred: ' + ex.getMessage()); // Handle other exceptions
        }

        return newsJsonData;
    }
    public Map<String, Object> fetchNewsData(){
        return getNewsData();
    }
}
