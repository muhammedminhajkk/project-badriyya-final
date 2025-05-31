import 'package:badriyya/core/navigation%20bar/custom_bottom_navigation_bar.dart';
import 'package:badriyya/features/public/more/view/widgets/more_builder.dart';
import 'package:flutter/material.dart';

class MorePage extends StatelessWidget {
  static const routePath = '/more';

  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            // top: 50,
            left: -80,
            child: Container(
              width: 380,
              height: 380,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [Color.fromARGB(255, 121, 232, 254), Colors.white],
                  radius: 0.5,
                ),
              ),
            ),
          ),
          Positioned(
            top: 500,
            left: 100,
            child: Container(
              width: 380,
              height: 380,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [Color.fromARGB(255, 121, 232, 254), Colors.white],
                  radius: 0.5,
                ),
              ),
            ),
          ),
          Column(
            children: [
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Center(
                    child: Image.asset(
                      height: 100,
                      "assets/Logo.png",
                      color: Colors.black,
                    ),
                  ),
                ),
              ),

              const Expanded(
                flex: 11,
                child: Padding(
                  padding: EdgeInsets.only(left: 24.0, right: 24),
                  child: MoreBuilder(),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 50, right: 50, bottom: 10),
                child: CustomBottomNavigationBar(currentIndex: 1),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
