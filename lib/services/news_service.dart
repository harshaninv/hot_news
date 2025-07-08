import 'package:dio/dio.dart';
import 'package:hot_news/models/news_response.dart';
import 'package:hot_news/services/api_client.dart';
import 'package:hot_news/services/api_end_points.dart';

class NewsService {
  final ApiClient _apiClient;

  NewsService(this._apiClient);

  Future<NewsResponse> getTopHeadlinesUS() async {
    try {
      final response = await _apiClient.get(ApiEndPoints.getNewsByCountry);

      if (response.statusCode == 200) {
        return NewsResponse.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw Exception('Failed to load top headlines: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print('Error response data: ${e.response!.data}');
        print('Error response headers: ${e.response!.headers}');
      }
      print('Dio error getting top headlines: ${e.message}');
      throw Exception('Network error or API issue: ${e.message}');
    } catch (e) {
      print('Unexpected error getting top headlines: $e');
      throw Exception('An unexpected error occurred: $e');
    }
  }

  // ApiEndPoints.getNewsByCountry + '&category=$category' for category filtering
  Future<NewsResponse> getNewsByCategory(String category) async {
    try {
      final response = await _apiClient.get(
        '${ApiEndPoints.getNewsByCountry}&category=$category',
      );

      if (response.statusCode == 200) {
        return NewsResponse.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw Exception('Failed to load news by category: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print('Error response data: ${e.response!.data}');
        print('Error response headers: ${e.response!.headers}');
      }
      print('Dio error getting news by category: ${e.message}');
      throw Exception('Network error or API issue: ${e.message}');
    } catch (e) {
      print('Unexpected error getting news by category: $e');
      throw Exception('An unexpected error occurred: $e');
    }
  }

  Future<NewsResponse> searchNews(String query) async {
    try {
      final response = await _apiClient.get(
        '${ApiEndPoints.searchNews}&q=${Uri.encodeComponent(query)}',
      );

      if (response.statusCode == 200) {
        return NewsResponse.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw Exception('Failed to search news: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print('Error response data: ${e.response!.data}');
        print('Error response headers: ${e.response!.headers}');
      }
      print('Dio error searching news: ${e.message}');
      throw Exception('Network error or API issue: ${e.message}');
    } catch (e) {
      print('Unexpected error searching news: $e');
      throw Exception('An unexpected error occurred: $e');
    }
  }
}
