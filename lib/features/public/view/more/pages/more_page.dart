import 'package:flutter/material.dart';
import 'package:project_badriyya/features/public/view/home/widgets/custom_bottom_navigation_bar.dart';
import 'package:project_badriyya/features/public/view/more/widgets/more_builder.dart';

class MorePage extends StatelessWidget {
  static const routePath = '/more';

  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Image.asset(
                "assets/blackicon.png",
              ),
            ),
          ),
          Expanded(
            // flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 24, top: 12),
              child: Container(
                padding: const EdgeInsets.only(left: 18, right: 18),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(236, 236, 236, 255),
                    // rgba(236, 236, 236, 1)
                    borderRadius: BorderRadius.circular(10)),
                child: const Row(
                  children: [
                    // SizedBox(
                    //   width: 20,
                    // ),
                    Text(
                      "Search Here",
                      style: TextStyle(fontSize: 16),
                    ),
                    Expanded(
                      child: SizedBox(),
                    ),
                    Icon(Icons.search)
                  ],
                ),
              ),
            ),
          ),
          const Expanded(
            flex: 10,
            child: Padding(
              padding: EdgeInsets.only(left: 24.0, right: 24),
              child: MoreBuilder(),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 50, right: 50, bottom: 10),
            child: CustomBottomNavigationBar(currentIndex: 1),
          )
        ],
      ),
    );
  }
}
