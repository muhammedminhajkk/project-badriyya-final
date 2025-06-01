import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> updateAttendance({
  required String classId,
  required String date,
  required int period,
  required List<String> userIds,
}) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('access_token');

  if (token == null) throw Exception("Access token missing");

  final url = Uri.parse(
    "https://api.badriyya.in/class/attendance",
  ); // Adjust if different

  final response = await http.post(
    url,
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'classId': classId,
      'date': date,
      'period': period,
      'UserIds': userIds,
    }),
  );

  // print('🔁 Update Status: ${response.statusCode}');
  // print('📨 Update Body: ${response.body}');

  return response.statusCode == 200 || response.statusCode == 201;
}
