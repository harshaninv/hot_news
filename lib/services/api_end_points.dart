import 'package:hot_news/secrets.dart';

class ApiEndPoints {
  static String baseUrl = "https://newsapi.org/v2/";

  // api key access from secrets.dart
  static const String _apiKey = Secrests.newsApi;

  static String searchNews =
      "everything?language=en&sortBy=publishedAt&apiKey=$_apiKey";
  static String getNewsByCountry = "top-headlines?country=us&apiKey=$_apiKey";
  // static String getNewsByCategory =
  //     "top-headlines?category=sports&apiKey=${_apiKey}";
}
