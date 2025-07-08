

import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiEndPoints {
  static String baseUrl = "https://newsapi.org/v2/";

  // api key access from dotenv
  static String _apiKey = dotenv.env['NEWS_API_KEY']!; 

  static String searchNews =
      "everything?language=en&sortBy=publishedAt&apiKey=$_apiKey";
  static String getNewsByCountry = "top-headlines?country=us&apiKey=$_apiKey";
  // static String getNewsByCategory =
  //     "top-headlines?category=sports&apiKey=$_apiKey";
}
