import 'dart:convert';

import 'package:badriyya/features/public/dashboard/login/widgets/refresh_token.dart';
import 'package:badriyya/features/public/dashboard/teachers/model/class_model.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<List<ClassModel>> fetchClasses({bool forceRefresh = false}) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('access_token');
  final classesBox = Hive.box<List>('classesBox');

  if (forceRefresh) {
    return await _fetchFromAPI(token, classesBox);
  }

  final cached = classesBox.get('teacher_classes')?.cast<ClassModel>();
  if (cached != null && cached.isNotEmpty) {
    _tryFetchAndUpdateFromAPI(token, classesBox); // fire-and-forget
    return Future.value(cached);
  }

  return await _fetchFromAPI(token, classesBox);
}

Future<void> _tryFetchAndUpdateFromAPI(String? token, Box<List> box) async {
  final url = Uri.parse('https://api.badriyya.in/class');

  try {
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      final classes = jsonData.map((e) => ClassModel.fromJson(e)).toList();
      await box.put('teacher_classes', classes);
    }
  } catch (_) {
    // Silent fail, user is already seeing cached data
  }
}

Future<List<ClassModel>> _fetchFromAPI(String? token, Box<List> box) async {
  final url = Uri.parse('https://api.badriyya.in/class');

  final response = await http.get(
    url,
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    final List<dynamic> jsonData = jsonDecode(response.body);
    final classes = jsonData.map((e) => ClassModel.fromJson(e)).toList();
    await box.put('teacher_classes', classes);
    return classes;
  } else if (response.statusCode == 401) {
    final refreshed = await refreshAccessToken();
    if (refreshed) {
      final newPrefs = await SharedPreferences.getInstance();
      final newToken = newPrefs.getString('access_token');
      return await _fetchFromAPI(newToken, box); // retry once
    } else {
      throw Exception('Unauthorized and refresh failed');
    }
  } else {
    throw Exception('Failed to load classes from API');
  }
}
