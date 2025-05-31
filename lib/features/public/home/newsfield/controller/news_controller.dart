import 'dart:convert';

import 'package:badriyya/features/public/home/newsfield/model/news_model.dart';
import 'package:badriyya/features/public/home/newsfield/services/news_service.dart';
import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final newsProvider = FutureProvider<List<NewsItem>>((ref) async {
  final newsController = NewsController();
  return await newsController.getNews();
});

class NewsController {
  final NewsService _newsService = NewsService();
  static const String _cacheKey = 'cached_news';

  Future<List<NewsItem>> getNews() async {
    final prefs = await SharedPreferences.getInstance();

    // Load cached news
    final cachedData = prefs.getString(_cacheKey);
    List<NewsItem> cachedNews = [];
    if (cachedData != null) {
      try {
        final List<dynamic> jsonList = json.decode(cachedData);
        cachedNews = jsonList.map((item) => NewsItem.fromJson(item)).toList();
      } catch (e) {
        debugPrint('Error decoding cached news: $e');
      }
    }

    // Fetch new data in the background
    try {
      final freshNews = await _newsService.fetchNews();
      // Update cache
      prefs.setString(
        _cacheKey,
        json.encode(freshNews.map((e) => e.toJson()).toList()),
      );
      return freshNews;
    } catch (e) {
      debugPrint('Error fetching fresh news: $e');
      // Return cached news if fetching fails
      return cachedNews;
    }
  }
}
