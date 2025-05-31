import 'package:badriyya/features/public/dashboard/teachers/model/class_period_model.dart';
import 'package:badriyya/features/public/dashboard/teachers/pages/teacher_attendance_page.dart';
import 'package:badriyya/features/public/dashboard/teachers/service/class_period_fetching.dart';
import 'package:badriyya/features/public/dashboard/teachers/widgets/class_period_widget.dart';
import 'package:flutter/material.dart';

class ClassPeriodListPage extends StatelessWidget {
  final String classId;
  const ClassPeriodListPage({super.key, required this.classId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Class Periods")),
      body: FutureBuilder<List<ClassPeriodModel>>(
        future: fetchClassPeriods(classId),
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
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder:
                          (context) => PeriodPeoplePage(
                            periodName: periods[index].subject,
                            period: periods[index].period,
                            classId: classId,
                          ),
                    ),
                  );
                },
                child: ClassPeriodWidget(model: periods[index]),
              );
            },
          );
        },
      ),
    );
  }
}
