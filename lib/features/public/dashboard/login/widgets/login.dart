import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> login(String email, String password) async {
  final url = Uri.parse('https://api.badriyya.in/auth/admin/login');

  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    // print('Status code: ${response.statusCode}');
    // print('Response: ${response.body}');

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final data = jsonDecode(response.body);
      final accessToken = data['access_token'];
      final refreshToken = data['refresh_token'];
      final userrole = data['user']['role'];
      final userid = data['user']['id'];

      if (accessToken != null && refreshToken != null && userrole != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('access_token', accessToken);
        await prefs.setString('refresh_token', refreshToken);
        await prefs.setString('role', userrole);
        await prefs.setString('user_id', userid);

        // print('✅ Login successful! Tokens and user ID saved.');
        return true;
      } else {
        // print('⚠️ One or more fields (token/user ID) missing in response.');
        return false;
      }
    } else {
      // print('❌ Login failed with status: ${response.statusCode}');
      return false;
    }
  } catch (e) {
    // print('🔥 Error during login: $e');
    return false;
  }
}
