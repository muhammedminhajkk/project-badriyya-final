import 'package:badriyya/features/public/gradient_text.dart';
import 'package:badriyya/features/public/home/newsfield/controller/news_controller.dart';
import 'package:badriyya/features/public/home/newsfield/view/dummy_news.dart';
import 'package:badriyya/features/public/home/newsfield/view/news_feed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Updates extends ConsumerWidget {
  const Updates({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newsAsync = ref.watch(newsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const GradientText("Updates"),
        backgroundColor: Colors.grey[300],
        leading: const BackButton(color: Colors.black),
      ),
      body: newsAsync.when(
        data: (news) {
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 252, 254, 255),
                  Color.fromARGB(255, 161, 217, 255),
                ],
              ),
            ),
            child: ListView.builder(
              itemCount: news.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return const SizedBox(height: 5);
                }
                return Padding(
                  padding: const EdgeInsets.only(
                    left: 8.0,
                    bottom: 8,
                    right: 8,
                  ),
                  child: NewsFeed(news: news[index - 1]),
                );
              },
            ),
          );
        },
        loading: () => const DummyNews(),
        error:
            (err, stack) => const Center(child: Text("Failed to load news.")),
      ),
    );
  }
}
