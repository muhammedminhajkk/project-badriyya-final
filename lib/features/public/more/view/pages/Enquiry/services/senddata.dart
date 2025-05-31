import 'dart:convert';

import 'package:http/http.dart' as http;

class EnquiryService {
  static const String apiUrl =
      'https://badriyya.in/api/enquiry'; // Update this to your backend URL

  // Send enquiry data to the backend
  static Future<bool> sendEnquiry(Map<String, String> data) async {
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
        // Handle the error from backend response
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
