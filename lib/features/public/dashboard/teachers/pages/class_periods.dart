import 'package:badriyya/features/public/dashboard/teachers/model/class_period_model.dart';
import 'package:badriyya/features/public/dashboard/teachers/pages/add_schedule.dart';
import 'package:badriyya/features/public/dashboard/teachers/pages/student_with_attendance.dart';
import 'package:badriyya/features/public/dashboard/teachers/service/class_period_fetching.dart';
import 'package:badriyya/features/public/dashboard/teachers/widgets/class_period_widget.dart';
import 'package:badriyya/features/public/dashboard/teachers/widgets/morning_and_evening_attendance_card.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClassPeriodListPage extends StatefulWidget {
  final String classId;
  const ClassPeriodListPage({super.key, required this.classId});

  @override
  State<ClassPeriodListPage> createState() => _ClassPeriodListPageState();
}

class _ClassPeriodListPageState extends State<ClassPeriodListPage> {
  late Future<List<ClassPeriodModel>> _futurePeriods;
  String? role;
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _loadData();
    _futurePeriods = fetchClassPeriods(
      widget.classId,
      _formattedDate(selectedDate),
    );
    // _futurePeriods = fetchClassPeriodsWithDate(widget.classId, _formattedDate(selectedDate));
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      role = prefs.getString('role');
    });
  }

  String _formattedDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.blueAccent,
              onPrimary: Colors.white,
              onSurface: Colors.black87,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: Colors.blueAccent),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _futurePeriods = fetchClassPeriods(
          widget.classId,
          _formattedDate(selectedDate),
        );

        // _futurePeriods = fetchClassPeriodsWithDate(widget.classId, _formattedDate(selectedDate));
      });
    }
  }

  Future<void> _refresh() async {
    setState(() {
      _futurePeriods = fetchClassPeriods(
        widget.classId,
        _formattedDate(selectedDate),
      );

      // _futurePeriods = fetchClassPeriodsWithDate(widget.classId,);
    });
    await _futurePeriods;
  }

  String _getDayName(DateTime date) {
    // List of day names
    const dayNames = [
      "Sunday",
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday",
    ];
    // Get the day of the week as an integer (0 = Sunday, 1 = Monday, ..., 6 = Saturday)
    int dayIndex = date.weekday % 7;
    // Return the corresponding day name
    return dayNames[dayIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Class Periods"),
        actions: [
          if (role == 'admin')
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddSchedule(classid: widget.classId),
                  ),
                ).then((_) => _refresh());
              },
            ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: _pickDate,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blueAccent, width: 1.2),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 18,
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today, color: Colors.blueAccent),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          // Day name as title
                          _getDayName(selectedDate),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Colors.blueAccent,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          // Date as subtitle
                          _formattedDate(selectedDate),
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    const Icon(Icons.edit_calendar, color: Colors.blueAccent),
                    const SizedBox(width: 4),
                    const Text(
                      "Change",
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<ClassPeriodModel>>(
              future: _futurePeriods,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (!snapshot.hasData) {
                  return const Center(child: Text("No periods found."));
                }

                final periods = snapshot.data ?? [];

                return RefreshIndicator(
                  onRefresh: _refresh,
                  child: ListView.builder(
                    itemCount: periods.length + 2,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        // Morning Attendance Card
                        return MorningAndEveningAttendanceCard(
                          title: "Morning",
                          startColor: const Color(0xFF4F8FFF),
                          endColor: const Color(0xFF6FE7DD),
                          iconColor: const Color(0xFF4F8FFF),
                          avatarBgColor: const Color(0xFFe3f0ff),
                          textColor: const Color(0xFF1A237E),
                          icon: Icons.wb_sunny,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => StudentAttendancePage(
                                      classId: widget.classId,
                                      date: _formattedDate(selectedDate),
                                      period: 11,
                                      subjectName: "Morning Attendance",
                                    ),
                              ),
                            );
                          },
                        );
                      } else if (index == periods.length + 1) {
                        // Evening Attendance Card
                        return MorningAndEveningAttendanceCard(
                          title: "Evening",
                          startColor: const Color(0xFFFF6F91),
                          endColor: const Color(0xFFFFC371),
                          iconColor: const Color(0xFFFF6F91),
                          avatarBgColor: const Color(0xFFFFE3E3),
                          textColor: const Color(0xFFB71C1C),
                          icon: Icons.nights_stay,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => StudentAttendancePage(
                                      classId: widget.classId,
                                      date: _formattedDate(selectedDate),
                                      period: 12,
                                      subjectName: "Evening Attendance",
                                    ),
                              ),
                            );
                          },
                        );
                      } else {
                        // Adjust index for periods list
                        final periodIndex = index - 1;
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => StudentAttendancePage(
                                      classId: widget.classId,
                                      date: _formattedDate(selectedDate),
                                      period: periods[periodIndex].period,
                                      subjectName: periods[periodIndex].subject,
                                    ),
                              ),
                            );
                          },
                          child: ClassPeriodWidget(model: periods[periodIndex]),
                        );
                      }
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
