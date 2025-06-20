import 'dart:convert';

import 'package:badriyya/features/public/dashboard/login/widgets/refresh_token.dart';
import 'package:badriyya/features/public/dashboard/teachers/model/class_period_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<List<ClassPeriodModel>> fetchClassPeriods(
  String classId,
  String date,
) async {
  final prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('access_token');

  if (token == null) throw Exception('Access token not found');

  final url = Uri.parse('https://api.badriyya.in/schedules/class');
  final body = {"classId": classId, "date": date};

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
      throw Exception('Session expired. Please login again.');
    }
  }

  if (response.statusCode == 200 || response.statusCode == 201) {
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((e) => ClassPeriodModel.fromJson(e)).toList();
  } else {
    throw Exception('Failed to fetch class periods: ${response.statusCode}');
  }
}
