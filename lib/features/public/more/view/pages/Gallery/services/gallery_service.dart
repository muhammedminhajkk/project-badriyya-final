import 'dart:convert';

import 'package:badriyya/features/public/more/view/pages/Gallery/services/gallery_model.dart';
import 'package:http/http.dart' as http;

class GalleryService {
  static const String _baseUrl = 'https://badriyya.in/api/gallery';
  static const String _apiKey = 'your_static_api_key';

  // Fetch advertisements from API
  Future<List<BannerModel>> fetchGallery() async {
    try {
      final response = await http.get(
        Uri.parse(_baseUrl),
        headers: {'X-API-KEY': _apiKey},
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        // print( jsonResponse);
        if (jsonResponse['status'] != 'success' ||
            jsonResponse['data'] == null) {
          throw Exception('Invalid API response format');
        }

        // Parse the advertisements from the response
        List<dynamic> galleryList = jsonResponse['data'];
        return galleryList.map((item) => BannerModel.fromJson(item)).toList();
      } else {
        throw Exception(
          'Failed to load advertisements (HTTP ${response.statusCode}) - ${response.body}',
        );
      }
    } catch (error) {
      throw Exception('Error fetching advertisements: $error');
    }
  }
}
