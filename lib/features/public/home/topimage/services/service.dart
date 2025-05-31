import 'dart:convert';

import 'package:http/http.dart' as http;

class BannerService {
  static const String _baseUrl = 'https://badriyya.in/api/banners';
  static const String _apiKey = 'your_static_api_key';

  Future<List<String>> fetchBannerImages() async {
    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {'X-API-KEY': _apiKey},
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        if (jsonResponse['status'] != 'success' ||
            jsonResponse['data'] == null) {
          throw Exception('Invalid API response format');
        }

        List<dynamic> dataList = jsonResponse['data'];

        List<String> imageUrls =
            dataList
                .map((item) => item['Banner']?['banner']?.toString() ?? '')
                .where((url) => url.isNotEmpty)
                .toList();
        return imageUrls;
      } else {
        throw Exception(
          'Failed to load banners (HTTP ${response.statusCode}) - ${response.body}',
        );
      }
    } catch (error) {
      throw Exception('Error fetching banners: $error');
    }
  }
}
