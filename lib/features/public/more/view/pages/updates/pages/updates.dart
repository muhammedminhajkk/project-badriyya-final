import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_badriyya/features/public/home/controller/news_controller.dart';
import 'package:project_badriyya/features/public/home/view/widgets/dummy_news.dart';
import 'package:project_badriyya/features/public/home/view/widgets/news_feed.dart';
import 'package:project_badriyya/features/public/home/view/widgets/update_text.dart';

class Updates extends ConsumerWidget {
  const Updates({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final newsController = ref.read(newsControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const GradientText("Updates"),
        backgroundColor: Colors.grey[300],
        leading: const BackButton(color: Colors.black),
      ),
      body: FutureBuilder(
          future: newsController.fetchNews(),
          builder: (context, snapshot) {
            final news = snapshot.data;
            if (snapshot.connectionState == ConnectionState.waiting ||
                news == null) {
              return const DummyNews();
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
    );
  }
}
