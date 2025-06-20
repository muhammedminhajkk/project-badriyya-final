import 'package:badriyya/core/navigation%20bar/dashboard_bottom_bar.dart';
import 'package:badriyya/features/public/dashboard/teachers/model/teacher_period_model.dart';
import 'package:badriyya/features/public/dashboard/teachers/pages/student_with_attendance.dart';
import 'package:badriyya/features/public/dashboard/teachers/service/teacher_schedule_fetching.dart';
import 'package:badriyya/features/public/dashboard/teachers/widgets/modal_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/period_card.dart';

class TeacherPeriodsPage extends StatefulWidget {
  static const routePath = '/schedule';
  final bool isMain;

  const TeacherPeriodsPage({Key? key, this.isMain = true}) : super(key: key);

  @override
  State<TeacherPeriodsPage> createState() => _TeacherPeriodsPageState();
}

class _TeacherPeriodsPageState extends State<TeacherPeriodsPage> {
  late SharedPreferences prefs;
  String? role;
  bool _prefsLoaded = false;

  @override
  void initState() {
    super.initState();
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      role = prefs.getString('role');
      _prefsLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          "Today's Periods",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2C5364),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        actions: [
          if (_prefsLoaded)
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                if (role != null) {
                  showSettingsSheet(context: context, role: role, prefs: prefs);
                }
              },
            ),
          const SizedBox(width: 15),
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFE0EAFC), Color(0xFFCFDEF3)],
              ),
            ),
            child: FutureBuilder<List<TeacherPeriodModel>>(
              future: fetchTeacherPeriods(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("No periods found."));
                }

                final periods = snapshot.data!;

                return ListView.builder(
                  itemCount: periods.length,
                  itemBuilder: (context, index) {
                    final period = periods[index];
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder:
                                (context) => StudentAttendancePage(
                                  period: period.period,
                                  classId: period.classId,
                                  date:
                                      "${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}",
                                  subjectName: period.subject,
                                ),
                          ),
                        );
                      },
                      child: PeriodCard(
                        subject: period.subject,
                        hour: period.startTime,
                        time: period.endTime,
                        section: period.className,
                      ),
                    );
                  },
                );
              },
            ),
          ),
          if (widget.isMain)
            const Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(left: 50, right: 50, bottom: 10),
                child: DashboardBottomBar(currentIndex: 0),
              ),
            ),
        ],
      ),
    );
  }
}
