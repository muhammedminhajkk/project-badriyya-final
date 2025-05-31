import 'dart:convert';

import 'package:http/http.dart' as http;

class DuaService {
  static const String apiUrl = 'https://badriyya.in/api/dua';

  // Send dua request to the backend
  static Future<bool> sendDuaRequest(Map<String, String> data) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        // Successfully posted data
        return true;
      } else {
        // Handle backend error response
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
