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

  @override
  void initState() {
    super.initState();
    _loadData();
    _futurePeriods = fetchClassPeriods(widget.classId);
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      role = prefs.getString('role');
    });
  }

  Future<void> _refresh() async {
    setState(() {
      _futurePeriods = fetchClassPeriods(widget.classId);
    });
    await _futurePeriods;
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
      body: FutureBuilder<List<ClassPeriodModel>>(
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
                                date:
                                    "${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}",
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
                                date:
                                    "${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}",
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
                                date:
                                    "${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}",
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
    );
  }
}
