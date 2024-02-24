public with sharing class newsController {
  public static Map< String, Object>   retriveNews(){
    HttpRequest httpRequest = new HttpRequest()
    httpRequest.setEndpoint('https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=7b6f8c2f8884438dbb74fcc05b489aad');

  }
}