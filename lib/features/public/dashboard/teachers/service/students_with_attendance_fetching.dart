import 'dart:convert';

import 'package:badriyya/features/public/dashboard/teachers/model/student_attendance_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<List<StudentAttendanceModel>> fetchStudentAttendance({
  required String classId,
  required String date,
  required int period,
}) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('access_token');

  if (token == null) throw Exception('Access token not found');

  final url = Uri.parse('https://api.badriyya.in/class/attendance/period');

  final response = await http.post(
    url,
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
    body: jsonEncode({'classId': classId, 'date': date, 'period': period}),
  );

  // print('⏳ Response Status: ${response.statusCode}');
  // print('📦 Response Body: ${response.body}');

  if (response.statusCode == 200 || response.statusCode == 201) {
    final List data = jsonDecode(response.body);
    return data.map((e) => StudentAttendanceModel.fromJson(e)).toList();
  } else {
    throw Exception('Failed to fetch attendance data: ${response.statusCode}');
  }
}
