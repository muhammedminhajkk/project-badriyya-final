import 'package:flutter/material.dart';
import 'package:project_badriyya/features/public/home/model/news_model.dart';
import 'package:project_badriyya/features/public/home/services/news_service.dart';
import 'package:riverpod/riverpod.dart';

final newsControllerProvider = Provider((ref) => NewsController());

class NewsController {
  final NewsService _newsService = NewsService();

  Future<List<NewsItem>?> fetchNews() async {
    try {
      return await _newsService.fetchNews();
    } catch (e) {
      debugPrint('Error fetching news: $e');
      return null; // Return null instead of throwing error
    }
  }
}
