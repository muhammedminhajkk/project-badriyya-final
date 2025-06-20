import 'package:badriyya/features/public/dashboard/login/pages/login.dart';
import 'package:badriyya/features/public/dashboard/teachers/pages/add_student.dart';
import 'package:badriyya/features/public/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> showSettingsSheet({
  required BuildContext context,
  required String? role,
  required SharedPreferences prefs,
}) async {
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
            if (role == 'admin')
              ListTile(
                leading: const Icon(Icons.person_add, color: Colors.green),
                title: const Text(
                  "Add Students",
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const AddStudentPage()),
                  );
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
                        content: const Text("Are you sure you want to logout?"),
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

                if (!context.mounted) return;

                if (confirm == true) {
                  Navigator.pop(context); // Close bottom sheet
                  await prefs
                      .clear(); // Removes all keys from SharedPreferences

                  // Ensure the box is opened and use the correct type
                  var classesBox = Hive.box<List>('classesBox');
                  await classesBox.clear(); // Clears the Hive box

                  if (!context.mounted) return;
                  GoRouter.of(context).go(Profile.routePath);
                }
              },
            ),
          ],
        ),
  );
}
