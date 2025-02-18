import 'package:flutter/material.dart';
import 'package:project_badriyya/features/public/view/home/widgets/custom_bottom_navigation_bar.dart';

class Profile extends StatelessWidget {
  static const routePath = '/profile';

  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Image.asset("assets/book.png"),
          ),
          const Column(
            children: [
              Expanded(child: SizedBox()),
              Padding(
                padding: EdgeInsets.only(left: 50, right: 50, bottom: 24),
                child: CustomBottomNavigationBar(currentIndex: 2),
              ),
            ],
          )
        ],
      ),
    );
  }
}
