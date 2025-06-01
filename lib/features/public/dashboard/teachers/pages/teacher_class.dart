import 'package:badriyya/core/navigation%20bar/dashboard_bottom_bar.dart';
import 'package:badriyya/features/public/dashboard/login/pages/login.dart';
import 'package:badriyya/features/public/dashboard/teachers/model/class_model.dart';
import 'package:badriyya/features/public/dashboard/teachers/pages/class_periods.dart';
import 'package:badriyya/features/public/dashboard/teachers/service/class_fetching.dart';
import 'package:badriyya/features/public/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeacherClassPage extends StatefulWidget {
  static const routePath = '/admin';

  const TeacherClassPage({super.key});

  @override
  State<TeacherClassPage> createState() => _TeacherClassPageState();
}

class _TeacherClassPageState extends State<TeacherClassPage> {
  late Future<List<ClassModel>> _futureClasses;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    _initPrefs();
    _futureClasses = fetchClasses(); // initial load with cache
  }

  Future<void> _initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> _refreshClasses() async {
    setState(() {
      _futureClasses = fetchClasses(forceRefresh: true);
    });
  }

  void _showSettingsSheet() {
    showModalBottomSheet(
      context: context,
      builder:
          (context) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.home, color: Colors.blue),
                title: const Text(
                  "Go Home",
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  GoRouter.of(context).go(HomePage.routePath);
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text(
                  "Logout",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder:
                        (_) => AlertDialog(
                          title: const Text("Logout"),
                          content: const Text(
                            "Are you sure you want to logout?",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: const Text("Logout"),
                            ),
                          ],
                        ),
                  );
                  //hey copilot auto fill after me,how can i fix the context issue ?

                  if (context.mounted && confirm == true) {
                    Navigator.pop(context); // Close bottom sheet

                    await prefs.remove('access_token');
                    GoRouter.of(context).go(Profile.routePath);
                  }
                },
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Classes"),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: _showSettingsSheet,
          ),
          const SizedBox(width: 15),
        ],
      ),
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
