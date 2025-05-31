import 'dart:convert';

import 'package:http/http.dart' as http;

class AdmissionService {
  static const String apiUrl = 'https://badriyya.in/api/admission';

  // Send admission data to the backend
  static Future<bool> submitAdmissionForm(Map<String, String> data) async {
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
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
