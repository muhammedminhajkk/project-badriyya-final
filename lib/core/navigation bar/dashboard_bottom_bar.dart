import 'package:badriyya/features/public/dashboard/teachers/pages/teacher_class.dart';
import 'package:badriyya/features/public/dashboard/teachers/pages/teacher_periods.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DashboardBottomBar extends StatelessWidget {
  final int currentIndex;
  const DashboardBottomBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade900,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildNavItem(
              context,
              Icons.class_, // Classes icon
              "Classes",
              0,
              TeacherClassPage.routePath,
            ),
          ),
          Expanded(
            child: _buildNavItem(
              context,
              Icons.schedule, // Schedules icon
              "Schedules",
              1,
              TeacherPeriodsPage.routePath,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    IconData icon,
    String label,
    int index,
    String route,
  ) {
    final isSelected = currentIndex == index;
    const gradient = LinearGradient(
      colors: [Color(0xFF00D2FF), Color.fromARGB(255, 4, 70, 117)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    return InkWell(
      onTap: () {
        if (!isSelected) {
          GoRouter.of(context).go(route);
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isSelected
              ? ShaderMask(
                shaderCallback: (Rect bounds) {
                  return gradient.createShader(bounds);
                },
                child: Icon(icon, color: Colors.white),
              )
              : Icon(icon, color: Colors.white),
          const SizedBox(height: 2),
          isSelected
              ? ShaderMask(
                shaderCallback: (Rect bounds) {
                  return gradient.createShader(
                    const Rect.fromLTWH(0, 0, 40, 16),
                  );
                },
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
              : Text(
                label,
                style: const TextStyle(fontSize: 10, color: Colors.white),
              ),
        ],
      ),
    );
  }
}
