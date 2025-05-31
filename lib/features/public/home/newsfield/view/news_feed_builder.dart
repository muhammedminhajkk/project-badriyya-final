import 'package:badriyya/core/navigation%20bar/custom_bottom_navigation_bar.dart';
import 'package:badriyya/features/public/gradient_text.dart';
import 'package:badriyya/features/public/home/newsfield/controller/news_controller.dart';
import 'package:badriyya/features/public/home/newsfield/view/dummy_news.dart';
import 'package:badriyya/features/public/home/newsfield/view/news_feed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewsFeedBuilder extends ConsumerWidget {
  const NewsFeedBuilder({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newsAsync = ref.watch(newsProvider);

    return Stack(
      children: [
        Positioned(
          top: -10,
          left: -80,
          child: Container(
            width: 280,
            height: 280,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  Color.fromARGB(255, 121, 232, 254),
                  Color.fromARGB(228, 255, 255, 255),
                ],
                radius: 0.5,
              ),
            ),
          ),
        ),
        Positioned(
          top: 100,
          left: 180,
          child: Container(
            width: 280,
            height: 280,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  Color.fromARGB(255, 121, 232, 254),
                  Color.fromARGB(229, 255, 255, 255),
                ],
                radius: 0.5,
              ),
            ),
          ),
        ),
        newsAsync.when(
          data: (news) {
            return ListView.builder(
              itemCount: news.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return const SizedBox(height: 35);
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
            );
          },
          loading: () => const DummyNews(),
          error: (err, stack) {
            return const Center(child: Text("Failed to load news."));
          },
        ),
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
        ),
      ],
    );
  }
}
