import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_badriyya/features/public/home/view/pages/home_page.dart';
import 'package:project_badriyya/features/public/more/view/pages/more_page.dart';
import 'package:project_badriyya/features/public/profile/view/pages/profile.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  const CustomBottomNavigationBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade900,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
              context, Icons.home_filled, "Home", 0, HomePage.routePath),
          _buildNavItem(
              context, Icons.grid_view_rounded, "more", 1, MorePage.routePath),
          _buildNavItem(context, Icons.account_circle_outlined, "Profile", 2,
              Profile.routePath),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, IconData icon, String label,
      int index, String route) {
    return InkWell(
      onTap: () {
        if (currentIndex != index) {
          GoRouter.of(context).go(route);
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: currentIndex == index ? Colors.blue : Colors.white,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: currentIndex == index ? Colors.blue : Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
