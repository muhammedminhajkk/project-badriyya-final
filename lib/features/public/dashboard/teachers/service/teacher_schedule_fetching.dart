import 'dart:convert';

import 'package:badriyya/features/public/dashboard/login/widgets/refresh_token.dart';
import 'package:badriyya/features/public/dashboard/teachers/model/teacher_period_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<List<TeacherPeriodModel>> fetchTeacherPeriods() async {
  final prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('access_token');
  final teacherId = prefs.getString('user_id');
  if (token == null) throw Exception('Access token not found');
  if (teacherId == null) throw Exception('Teacher ID not found');

  final url = Uri.parse('https://api.badriyya.in/schedules/teacher');
  final today = DateTime.now();
  final formattedDate =
      "${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";
  final body = {"teacherId": teacherId, "date": formattedDate};

  http.Response response = await http.post(
    url,
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
    body: jsonEncode(body),
  );

  // If token is expired, refresh and retry
  if (response.statusCode == 401) {
    final refreshed = await refreshAccessToken();
    if (refreshed) {
      token = prefs.getString('access_token');
      response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );
    } else {
      throw Exception('Session expired. Please log in again.');
    }
  }

  if (response.statusCode == 200 || response.statusCode == 201) {
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((e) => TeacherPeriodModel.fromJson(e)).toList();
  } else {
    throw Exception('Failed to fetch teacher periods: ${response.statusCode}');
  }
}
