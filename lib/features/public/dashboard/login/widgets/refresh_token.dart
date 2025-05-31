import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> refreshAccessToken() async {
  final prefs = await SharedPreferences.getInstance();
  final refreshToken = prefs.getString('refresh_token');

  if (refreshToken == null) return false;

  final url = Uri.parse('https://api.badriyya.in/auth/refresh');
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'refresh_token': refreshToken}),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final newAccess = data['access_token'];
    final newRefresh = data['refresh_token'];

    if (newAccess != null && newRefresh != null) {
      await prefs.setString('access_token', newAccess);
      await prefs.setString('refresh_token', newRefresh);
      return true;
    }
  }

  return false;
}
