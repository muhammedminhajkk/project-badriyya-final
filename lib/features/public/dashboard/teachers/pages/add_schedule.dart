import 'dart:convert';

import 'package:badriyya/features/public/dashboard/teachers/model/student_model.dart';
import 'package:badriyya/features/public/dashboard/teachers/service/student_fetching.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AddSchedule extends StatefulWidget {
  final String classid;
  const AddSchedule({super.key, required this.classid});

  @override
  State<AddSchedule> createState() => _AddScheduleState();
}

class _AddScheduleState extends State<AddSchedule> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dayOfWeekController = TextEditingController();
  final TextEditingController _periodController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _teacherIdController = TextEditingController();

  List<PersonModel> _teachers = [];
  String? _selectedTeacherId;
  bool _isLoadingTeachers = true;

  final List<String> _daysOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  @override
  void initState() {
    super.initState();
    _loadTeachers();
  }

  @override
  void dispose() {
    _dayOfWeekController.dispose();
    _periodController.dispose();
    _startTimeController.dispose();
    _endTimeController.dispose();
    _subjectController.dispose();
    _teacherIdController.dispose();
    super.dispose();
  }

  Future<void> _loadTeachers() async {
    setState(() => _isLoadingTeachers = true);
    try {
      final people = await fetchPeople();
      setState(() {
        _teachers = people.where((p) => p.role == 'teacher').toList();
        _isLoadingTeachers = false;
      });
    } catch (e) {
      if (mounted) {
        setState(() => _isLoadingTeachers = false);
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to load teachers: $e')));
    }
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    final Map<String, dynamic> body = {
      "classId": widget.classid,
      "dayOfWeek": _dayOfWeekController.text,
      "period": int.tryParse(_periodController.text) ?? 0,
      "startTime": _startTimeController.text,
      "endTime": _endTimeController.text,
      "subject": _subjectController.text,
      "teacherId": _selectedTeacherId,
    };

    try {
      final res = await http.post(
        Uri.parse(
          "https://api.badriyya.in/class/schedules",
        ), // Change endpoint if needed
        headers: {
          'Authorization': 'Bearer $token',
          "Content-Type": "application/json",
        },
        body: json.encode(body),
      );

      if (res.statusCode == 200 || res.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Schedule added successfully")),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to add schedule: ${res.body}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  Widget _buildTimeField(
    String label,
    TextEditingController controller, {
    IconData? icon,
  }) {
    return GestureDetector(
      onTap: () async {
        final TimeOfDay? picked = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
        if (picked != null) {
          final hour = picked.hour.toString().padLeft(2, '0');
          final minute = picked.minute.toString().padLeft(2, '0');
          controller.text = '$hour:$minute';
        }
      },
      child: AbsorbPointer(
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            border: const OutlineInputBorder(),
            prefixIcon: icon != null ? Icon(icon) : null,
          ),
          validator: (v) => v == null || v.isEmpty ? 'Required' : null,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Schedule')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Schedule Details",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Day of Week',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.calendar_today),
                      ),
                      value:
                          _dayOfWeekController.text.isNotEmpty
                              ? _dayOfWeekController.text
                              : null,
                      items:
                          _daysOfWeek
                              .map(
                                (day) => DropdownMenuItem(
                                  value: day,
                                  child: Text(day),
                                ),
                              )
                              .toList(),
                      onChanged: (val) {
                        setState(() {
                          _dayOfWeekController.text = val ?? '';
                        });
                      },
                      validator:
                          (val) =>
                              val == null || val.isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _periodController,
                      decoration: const InputDecoration(
                        labelText: 'Period',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.timelapse),
                      ),
                      keyboardType: TextInputType.number,
                      validator:
                          (v) => v == null || v.isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: 16),
                    _buildTimeField(
                      'Start Time (HH:mm)',
                      _startTimeController,
                      icon: Icons.access_time,
                    ),
                    const SizedBox(height: 16),
                    _buildTimeField(
                      'End Time (HH:mm)',
                      _endTimeController,
                      icon: Icons.access_time_filled,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _subjectController,
                      decoration: const InputDecoration(
                        labelText: 'Subject',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.book),
                      ),
                      validator:
                          (v) => v == null || v.isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: 16),
                    _isLoadingTeachers
                        ? const Center(child: CircularProgressIndicator())
                        : DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            labelText: "Select Teacher",
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.person),
                          ),
                          value: _selectedTeacherId,
                          items:
                              _teachers
                                  .map(
                                    (teacher) => DropdownMenuItem(
                                      value: teacher.id,
                                      child: Text(
                                        '${teacher.firstName} ${teacher.lastName}',
                                      ),
                                    ),
                                  )
                                  .toList(),
                          onChanged:
                              (val) => setState(() => _selectedTeacherId = val),
                          validator:
                              (val) =>
                                  val == null ? "Teacher is required" : null,
                        ),
                    const SizedBox(height: 30),
                    Center(
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.save),
                          label: const Text(
                            'Add Schedule',
                            style: TextStyle(fontSize: 16),
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: _submit,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
