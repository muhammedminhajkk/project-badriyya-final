import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:project_badriyya/features/public/home/model/news_model.dart';

class NewsService {
  static const String _baseUrl = 'https://badriyya.in/api/news';
  static const String _apiKey = 'your_static_api_key';

  Future<List<NewsItem>> fetchNews(
      {int page = 1, int limit = 10, String search = ""}) async {
    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'X-API-KEY': _apiKey,
          // 'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "search": search,
          "limit": limit.toString(),
          "page": page.toString(),
        }),
      );

      // Debug prints
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        // print(jsonResponse);
        if (jsonResponse['status'] != 'success' ||
            jsonResponse['data'] == null) {
          throw Exception('Invalid API response format');
        }

        List<dynamic> newsList = jsonResponse['data']['news'];
        // return newsList[0];
        return List.from(newsList.map((item) => NewsItem.fromJson(item)));
      } else {
        throw Exception(
            'Failed to load news (HTTP ${response.statusCode}) - ${response.body}');
      }
    } catch (error) {
      throw Exception('Error fetching news: $error');
    }
  }
}
