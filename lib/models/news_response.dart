import 'package:hot_news/models/article.dart';

class NewsResponse {
  NewsResponse({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  final String status;
  final int totalResults;
  final List<Article> articles;

  factory NewsResponse.fromJson(Map<String, dynamic> json) {
    // Deserialize the list of articles
    List<dynamic> articlesJson = json['articles'] as List<dynamic>;
    List<Article> articlesList = articlesJson
        .map((articleJson) => Article.fromJson(articleJson as Map<String, dynamic>))
        .toList();

    return NewsResponse(
      status: json['status'] as String,
      totalResults: json['totalResults'] as int,
      articles: articlesList,
    );
  }
}
