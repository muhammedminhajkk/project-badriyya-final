import 'dart:convert';

import 'package:badriyya/features/public/dashboard/teachers/model/student_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<List<PersonModel>> fetchPeople() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('access_token');
  // await prefs.remove('access_token');
  // print("Access Token: $token");

  if (token == null) {
    throw Exception('Access token not found');
  }

  final url = Uri.parse('https://api.badriyya.in/users');

  final response = await http.get(
    url,
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
  );
  // print("Status: ${response.statusCode}");
  // print("Body: ${response.body}");

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((e) => PersonModel.fromJson(e)).toList();
  } else {
    throw Exception('Failed to fetch people: ${response.statusCode}');
  }
}
