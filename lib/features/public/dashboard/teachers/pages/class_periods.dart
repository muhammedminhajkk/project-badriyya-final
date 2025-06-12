import 'package:badriyya/features/public/dashboard/teachers/model/class_period_model.dart';
import 'package:badriyya/features/public/dashboard/teachers/pages/add_schedule.dart';
import 'package:badriyya/features/public/dashboard/teachers/pages/student_with_attendance.dart';
import 'package:badriyya/features/public/dashboard/teachers/service/class_period_fetching.dart';
import 'package:badriyya/features/public/dashboard/teachers/widgets/class_period_widget.dart';
import 'package:flutter/material.dart';

class ClassPeriodListPage extends StatefulWidget {
  final String classId;
  const ClassPeriodListPage({super.key, required this.classId});

  @override
  State<ClassPeriodListPage> createState() => _ClassPeriodListPageState();
}

class _ClassPeriodListPageState extends State<ClassPeriodListPage> {
  late Future<List<ClassPeriodModel>> _futurePeriods;

  @override
  void initState() {
    super.initState();
    _futurePeriods = fetchClassPeriods(widget.classId);
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
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No periods found."));
          }

          final periods = snapshot.data!;

          return RefreshIndicator(
            onRefresh: _refresh,
            child: ListView.builder(
              itemCount: periods.length,
              itemBuilder: (context, index) {
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
                              period: periods[index].period,
                            ),
                      ),
                    );
                  },
                  child: ClassPeriodWidget(model: periods[index]),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
