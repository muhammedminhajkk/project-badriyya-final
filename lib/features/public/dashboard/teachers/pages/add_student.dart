import 'dart:convert';

import 'package:badriyya/features/public/dashboard/login/widgets/refresh_token.dart';
import 'package:badriyya/features/public/dashboard/teachers/model/class_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AddStudentPage extends StatefulWidget {
  const AddStudentPage({super.key});

  @override
  State<AddStudentPage> createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {};

  List<ClassModel> _classes = [];
  String? _selectedClassId;
  bool _isLoadingClasses = true;

  @override
  void initState() {
    super.initState();
    _loadClasses();
  }

  Future<void> _loadClasses() async {
    try {
      final classes = await fetchClassestwo();
      if (!mounted) return;
      setState(() {
        _classes = classes;
        _isLoadingClasses = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoadingClasses = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Failed to load classes: $e")));
    }
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedClassId == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please select a class")));
      return;
    }

    _formKey.currentState!.save();
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    final Map<String, dynamic> body = {
      "firstName": _formData['firstName'],
      "studentId": _formData['studentId'],
      "dob": _formData['dob'],
      "email": _formData['email'] ?? "student@gmail.com",
      "role": "student",
      "address": _formData['address'],
      "classId": _selectedClassId,
      "guardianName": _formData['guardianName'],
      "guardianPhone": _formData['guardianPhone'],
      "studentPhone": _formData['studentPhone'],
      "adhaar": _formData['adhaar'],
      "mothername": _formData['mothername'],
      "motherPhone": _formData['motherPhone'],
    };

    try {
      final res = await http.post(
        Uri.parse("https://api.badriyya.in/users"),
        headers: {
          'Authorization': 'Bearer $token',
          "Content-Type": "application/json",
        },
        body: json.encode(body),
      );

      if (!mounted) return;

      if (res.statusCode == 200 || res.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Student added successfully")),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to add student: ${res.body}")),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Student")),
      body:
          _isLoadingClasses
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      _buildDropdownField(),
                      _buildTextField("First Name", "firstName"),
                      _buildTextField("Student ID", "studentId"),
                      _buildTextField("Address", "address"),
                      _buildDatePickerField("Date of Birth", "dob"),
                      _buildTextField(
                        "Student Phone",
                        "studentPhone",
                        isPhone: true,
                      ),
                      _buildTextField("Adhaar", "adhaar"),
                      _buildTextField("Father Name", "guardianName"),
                      _buildTextField(
                        "Father Phone",
                        "guardianPhone",
                        isPhone: true,
                      ),
                      _buildTextField("Mother Name", "mothername"),
                      _buildTextField(
                        "Mother Phone",
                        "motherPhone",
                        isPhone: true,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _submitForm,
                        child: const Text("Submit"),
                      ),
                    ],
                  ),
                ),
              ),
    );
  }

  Widget _buildDropdownField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: DropdownButtonFormField<String>(
        decoration: const InputDecoration(
          labelText: "Select Class",
          border: OutlineInputBorder(),
        ),
        value: _selectedClassId,
        items:
            _classes
                .map(
                  (cls) =>
                      DropdownMenuItem(value: cls.id, child: Text(cls.name)),
                )
                .toList(),
        onChanged: (val) => setState(() => _selectedClassId = val),
        validator: (val) => val == null ? "Class is required" : null,
      ),
    );
  }

  Widget _buildTextField(String label, String field, {bool isPhone = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        keyboardType: isPhone ? TextInputType.phone : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "$label is required";
          }
          return null;
        },
        onSaved: (value) => _formData[field] = value?.trim(),
      ),
    );
  }

  Widget _buildDatePickerField(String label, String field) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GestureDetector(
        onTap: () async {
          final DateTime? picked = await showDatePicker(
            context: context,
            initialDate: DateTime(2005, 1, 1),
            firstDate: DateTime(1990),
            lastDate: DateTime.now(),
          );
          if (picked != null) {
            if (!mounted) return;
            setState(() {
              _formData[field] = "${picked.toLocal()}".split(' ')[0];
            });
          }
        },
        child: AbsorbPointer(
          child: TextFormField(
            decoration: InputDecoration(
              labelText: label,
              border: const OutlineInputBorder(),
            ),
            validator: (value) {
              if (_formData[field] == null || _formData[field].isEmpty) {
                return "$label is required";
              }
              return null;
            },
            controller: TextEditingController(text: _formData[field] ?? ''),
          ),
        ),
      ),
    );
  }
}

Future<List<ClassModel>> fetchClassestwo({bool forceRefresh = false}) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('access_token');
  final classesBox = Hive.box<List>('classesBox');

  if (forceRefresh) {
    return await _fetchFromAPI(token, classesBox);
  }

  final cached = classesBox.get('teacher_classes')?.cast<ClassModel>();
  if (cached != null && cached.isNotEmpty) {
    _tryFetchAndUpdateFromAPI(token, classesBox);
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
  } catch (_) {}
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
      return await _fetchFromAPI(newToken, box);
    } else {
      throw Exception('Unauthorized and refresh failed');
    }
  } else {
    throw Exception('Failed to load classes from API');
  }
}
