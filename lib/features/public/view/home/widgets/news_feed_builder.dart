import 'package:flutter/material.dart';
import 'package:project_badriyya/features/public/view/home/widgets/custom_bottom_navigation_bar.dart';
import 'package:project_badriyya/features/public/view/home/widgets/news_feed.dart';
import 'package:project_badriyya/features/public/view/home/widgets/update_text.dart';

class NewsFeedBuilder extends StatelessWidget {
  const NewsFeedBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              if (index == 0) {
                return const SizedBox(height: 5);
              }
              return const Padding(
                  padding: EdgeInsets.only(left: 8.0, bottom: 8, right: 8),
                  child: NewsFeed());
            }),
        Container(
          color: Colors.white.withOpacity(0.9),
          height: 30,
          width: double.infinity,
          child: const Padding(
            padding: EdgeInsets.only(left: 12.0),
            child: GradientText("Updates"),
          ),
        ),
        const Column(
          children: [
            Expanded(child: SizedBox()),
            Padding(
              padding: EdgeInsets.only(left: 50, right: 50, bottom: 24),
              child: CustomBottomNavigationBar(currentIndex: 0),
            ),
          ],
        )
      ],
    );
  }
}
