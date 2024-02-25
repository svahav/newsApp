public with sharing class NewsService {
    private static Map<String, Object> retrieveNews() {
        HttpRequest httpRequest = new HttpRequest();
        httpRequest.setEndpoint('https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=7b6f8c2f8884438dbb74fcc05b489aad');
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
                }
            } else {
                throw new CalloutException('HTTP Error: ' + httpResponse.getStatusCode() + ' ' + httpResponse.getStatus());
            }
        } catch (CalloutException ex) {
            throw ex; // Rethrow the CalloutException
        } catch (Exception ex) {
            throw new CalloutException('An unexpected error occurred: ' + ex.getMessage()); // Handle other exceptions
        }

        return newsJsonData;
    }

    public Map<String, Object> getNewsData(){
        return retrieveNews();
    }
}
