import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<void> submitAttendance({
  required String classId,
  required int period,
  required List<String> userIds,
}) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('access_token');

  if (token == null) throw Exception("Access token missing.");

  final url = Uri.parse('https://api.badriyya.in/class/attendance');

  final body = jsonEncode({
    "classId": classId,
    "date": DateTime.now().toIso8601String().split('T')[0], // "YYYY-MM-DD"
    "period": 6,
    "UserIds": userIds,
  });

  final response = await http.post(
    url,
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
    body: body,
  );

  if (response.statusCode < 200 || response.statusCode >= 300) {
    throw Exception("Failed to submit attendance: ${response.body}");
  }
}
