// lib/controllers/news_controller.dart

import 'package:flutter/material.dart';
import 'package:hot_news/models/article.dart';
import '../services/news_service.dart';
import '../models/news_response.dart';

enum NewsStatus { initial, loading, success, error }

class NewsController extends ChangeNotifier {
  final NewsService _newsService; // Dependency injection for NewsService

  NewsResponse? _newsResponse;
  NewsStatus _status = NewsStatus.initial;
  String? _errorMessage;
  String _currentCategory = 'general'; // Default category
  String? _currenSearchQuery;

  // Getter for public access to the data
  List<Article> get articles => _newsResponse?.articles ?? [];
  NewsStatus get status => _status;
  String? get errorMessage => _errorMessage;
  String get currentCategory => _currentCategory;
  String? get currentSearchQuery => _currenSearchQuery;

  NewsController(this._newsService); // Constructor to receive NewsService

  // Method to fetch news in US
  Future<void> fetchTopHeadlinesUS(String category) async {
    if (_currentCategory == category &&
        _status == NewsStatus.success &&
        _newsResponse != null) {
      return; // No need to fetch if the category is already set
    }

    _currentCategory = category; // Update the current category
    _status = NewsStatus.loading;
    _errorMessage = null;
    notifyListeners(); // Notify UI that loading has started

    try {
      NewsResponse response;
      if (category == 'general') {
        response = await _newsService.getTopHeadlinesUS();
      } else {
        response = await _newsService.getNewsByCategory(category);
      }
      _newsResponse = response;
      _status = NewsStatus.success;
    } catch (e) {
      _status = NewsStatus.error;
      _errorMessage = e.toString(); // Store the error message
      print('Error in NewsController: $e'); // Log for debugging
    } finally {
      notifyListeners(); // Notify UI that fetching is complete (success or error)
    }
  }

  // Method to fetch news by query to use in search functionality
  Future<void> fetchNewsByQuery(String query) async {
    // clear category selection when a search is performed
    _currentCategory = ''; // Reset to default category
    _currenSearchQuery = query; // Store the current search query
    _status = NewsStatus.loading;
    _errorMessage = null;
    notifyListeners(); // Notify UI that loading has started

    try {
      final response = await _newsService.searchNews(query);
      _newsResponse = response;
      _status = NewsStatus.success;
    } catch (e) {
      _status = NewsStatus.error;
      _errorMessage = e.toString(); // Store the error message
      print('Error in NewsController: $e'); // Log for debugging
    } finally {
      notifyListeners(); // Notify UI that fetching is complete (success or error)
    }
  }

  // helper to reset to default view when search is cleared
  void resetToDefaultView() {
    if (_currentCategory != 'general' || _currenSearchQuery != null) {
      _currentCategory = 'general'; // Reset to default category
      _currenSearchQuery = null; // Clear search query
      _status = NewsStatus.loading; // Reset status to initial
      _newsResponse = null; // Clear the news response
      notifyListeners(); // Notify UI to reset the view
    } else {
      // If already in default view, no need to fetch again
      return;
    }
    fetchTopHeadlinesUS('general'); // Fetch top headlines for the default category
  }
}
