public with sharing class newsController {
  public static Map< String, Object>   retriveNews(){
    HttpRequest httpRequest = new HttpRequest();
    httpRequest.setEndpoint('https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=7b6f8c2f8884438dbb74fcc05b489aad');
    httpsRequest.setMethod('GET');

    Map<String, Object> newsJsonData = new Map<String, Object>();
    String strResponse = null;

    try{
        Http http = new Http();
        HttpResponse httpResponse = http.send(httpRequest);
        if(HttpResponse.getStatusCode()==200){
            strResponse = httpResponse.getBody();
        } else{
            throw new CalloutException(httpResponse.getBody());
        }
    } catch(Exception ex){
        throw ex;
    }

    if(!String.isBlank(strResponse)){
        newsJsonData = (Map<String, Object>)JSON.deserializeUntyped(strResponse);
    }
    if(!newsJsonData.isEmpty()){
        return newsJsonData;
    } else {
        return null;
    }


  }
}