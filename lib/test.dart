import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_badriyya/features/public/home/controller/news_controller.dart';

class TestPage extends ConsumerWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final newsController = ref.read(newsControllerProvider);

    return Scaffold(
      body: FutureBuilder(
          future: newsController.fetchNews(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Center(
                child: Text(snapshot.data.toString()),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
