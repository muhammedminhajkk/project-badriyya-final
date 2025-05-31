import 'dart:convert';

import 'package:badriyya/features/public/home/topimage/services/service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// FutureProvider for fetching banner image URLs
final bannerProvider = FutureProvider<List<String>>((ref) async {
  final bannerController = BannerController();
  return await bannerController.getBanners();
});

class BannerController {
  final BannerService _bannerService = BannerService();
  static const String _cacheKey = 'cached_banners';

  Future<List<String>> getBanners() async {
    final prefs = await SharedPreferences.getInstance();

    // Load cached banners
    final cachedData = prefs.getString(_cacheKey);
    List<String> cachedBanners = [];
    if (cachedData != null) {
      try {
        cachedBanners = List<String>.from(json.decode(cachedData));
      } catch (e) {
        // Handle decoding error
      }
    }

    // Fetch new banners in the background
    try {
      final freshBanners = await _bannerService.fetchBannerImages();
      // Update cache
      prefs.setString(_cacheKey, json.encode(freshBanners));
      return freshBanners;
    } catch (e) {
      // Return cached banners if fetching fails
      return cachedBanners;
    }
  }
}
