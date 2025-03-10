import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_badriyya/features/public/home/controller/news_controller.dart';
import 'package:project_badriyya/features/public/home/view/widgets/custom_bottom_navigation_bar.dart';
import 'package:project_badriyya/features/public/home/view/widgets/news_feed.dart';
import 'package:project_badriyya/features/public/home/view/widgets/update_text.dart';

class NewsFeedBuilder extends ConsumerWidget {
  const NewsFeedBuilder({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final newsController = ref.read(newsControllerProvider);
    return Stack(
      children: [
        FutureBuilder(
            future: newsController.fetchNews(),
            builder: (context, snapshot) {
              final news = snapshot.data;
              if (snapshot.connectionState == ConnectionState.waiting ||
                  news == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return ListView.builder(
                    itemCount: news.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return const SizedBox(height: 5);
                      }
                      return Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, bottom: 8, right: 8),
                          child: NewsFeed(
                            news: news[index - 1],
                          ));
                    });
              }
            }),
        Container(
          color: const Color.fromARGB(229, 255, 255, 255),
          height: 30,
          width: double.infinity,
          child: const Padding(
            padding: EdgeInsets.only(left: 12.0, top: 2),
            child: GradientText("Updates"),
          ),
        ),
        const Column(
          children: [
            Expanded(child: SizedBox()),
            Padding(
              padding: EdgeInsets.only(left: 50, right: 50, bottom: 10),
              child: CustomBottomNavigationBar(currentIndex: 0),
            ),
          ],
        )
      ],
    );
  }
}
