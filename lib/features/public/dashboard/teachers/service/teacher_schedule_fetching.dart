import 'dart:convert';

import 'package:badriyya/features/public/dashboard/login/widgets/refresh_token.dart';
import 'package:badriyya/features/public/dashboard/teachers/model/teacher_period_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<List<TeacherPeriodModel>> fetchTeacherPeriods() async {
  final prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('access_token');
  final userId = prefs.getString('user_id');
  if (token == null) throw Exception('Access token not found');

  final url = Uri.parse('https://api.badriyya.in/class/teacher/$userId');

  http.Response response = await http.get(
    url,
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
  );

  // 🔁 If token is expired, refresh and retry
  if (response.statusCode == 401) {
    final refreshed = await refreshAccessToken();
    if (refreshed) {
      token = prefs.getString('access_token');
      response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
    } else {
      throw Exception('Session expired. Please log in again.');
    }
  }

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((e) => TeacherPeriodModel.fromJson(e)).toList();
  } else {
    throw Exception('Failed to fetch teacher periods: ${response.statusCode}');
  }
}
