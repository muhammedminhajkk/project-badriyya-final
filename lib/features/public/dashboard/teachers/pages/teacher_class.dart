import 'package:badriyya/core/navigation%20bar/dashboard_bottom_bar.dart';
import 'package:badriyya/features/public/dashboard/teachers/model/class_model.dart';
import 'package:badriyya/features/public/dashboard/teachers/pages/class_periods.dart';
import 'package:badriyya/features/public/dashboard/teachers/service/class_fetching.dart';
import 'package:flutter/material.dart';

class TeacherClassPage extends StatefulWidget {
  static const routePath = '/admin';

  const TeacherClassPage({super.key});

  @override
  State<TeacherClassPage> createState() => _TeacherClassPageState();
}

class _TeacherClassPageState extends State<TeacherClassPage> {
  late Future<List<ClassModel>> _futureClasses;

  @override
  void initState() {
    super.initState();
    _futureClasses = fetchClasses(); // initial load with cache
  }

  Future<void> _refreshClasses() async {
    setState(() {
      _futureClasses = fetchClasses(forceRefresh: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Classes")),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<ClassModel>>(
              future: _futureClasses,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("No classes found."));
                }

                final classes = snapshot.data!;

                return RefreshIndicator(
                  onRefresh: _refreshClasses,
                  child: ListView.builder(
                    itemCount: classes.length,
                    itemBuilder: (context, index) {
                      final classItem = classes[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder:
                                  (context) => ClassPeriodListPage(
                                    classId: classItem.id,
                                  ),
                            ),
                          );
                        },
                        child: Card(
                          margin: const EdgeInsets.all(8),
                          child: ListTile(
                            leading: CircleAvatar(child: Text("${index + 1}")),
                            title: Text(
                              classItem.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            trailing: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.blueAccent.withAlpha(26),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                classItem.students.length.toString(),
                                style: const TextStyle(
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 50, right: 50, bottom: 10),
            child: DashboardBottomBar(currentIndex: 0),
          ),
        ],
      ),
    );
  }
}
