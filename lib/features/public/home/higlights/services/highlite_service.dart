import 'dart:convert';

import 'package:badriyya/features/public/home/higlights/model/higlight_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AdvertisementService {
  static const String _baseUrl = 'https://badriyya.in/api/ads';
  static const String _apiKey = 'your_static_api_key';
  static const String _cacheKey = 'cached_ads';

  // Fetch from API and cache locally
  Future<List<Advertisement>> fetchAdvertisements() async {
    try {
      final response = await http.get(
        Uri.parse(_baseUrl),
        headers: {'X-API-KEY': _apiKey},
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['status'] != 'success' ||
            jsonResponse['data'] == null) {
          throw Exception('Invalid API response format');
        }

        List<dynamic> adsList = jsonResponse['data'];
        List<Advertisement> ads =
            adsList.map((item) => Advertisement.fromJson(item)).toList();

        // Cache the ads locally
        final prefs = await SharedPreferences.getInstance();
        final encoded = json.encode(ads.map((ad) => ad.toJson()).toList());
        await prefs.setString(_cacheKey, encoded);

        return ads;
      } else {
        throw Exception(
          'Failed to load advertisements (HTTP ${response.statusCode})',
        );
      }
    } catch (error) {
      throw Exception('Error fetching advertisements: $error');
    }
  }

  // Load from local cache
  Future<List<Advertisement>> loadCachedAdvertisements() async {
    final prefs = await SharedPreferences.getInstance();
    final cached = prefs.getString(_cacheKey);
    if (cached != null) {
      List<dynamic> list = json.decode(cached);
      return list
          .map(
            (item) => Advertisement(
              title: item['title'] ?? '',
              shortDesc: item['short_desc'] ?? '',
              desc: item['desc'] ?? '',
              image: item['image'] ?? '',
              url: item['url'] ?? '',
            ),
          )
          .toList();
    }
    return [];
  }
}
