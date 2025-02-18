import 'package:flutter/material.dart';
import 'package:project_badriyya/features/public/view/home/widgets/card_widget_builder.dart';
import 'package:project_badriyya/features/public/view/home/widgets/news_feed_builder.dart';
import 'package:project_badriyya/features/public/view/home/widgets/top_image_builder.dart';

class HomePage extends StatelessWidget {
  static const routePath = '/home';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 25, child: TopImageBuilder()),
          SizedBox(height: 20),
          Expanded(flex: 13, child: HighLights()),
          Expanded(flex: 36, child: NewsFeedBuilder())
        ],
      ),
    );
  }
}
