import 'package:badriyya/features/public/home/newsfield/model/news_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FullNewsPage extends StatelessWidget {
  final NewsItem news;

  const FullNewsPage({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Center(
          child: Container(
            height: 40, // Set the desired height
            width: 40, // Set the desired width
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromARGB(110, 0, 0, 0),
            ),
            child: Center(
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 250,
              width: double.infinity,
              child: CachedNetworkImage(
                imageUrl:
                    "https://badriyya.in/timthumb/image?src=/app/webroot/img/post/${news.blog.image}&q=80&a=c&zc=1&ct=1&w=490&h=295",
                placeholder:
                    (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                errorWidget:
                    (context, url, error) =>
                        const Icon(Icons.error, color: Colors.red),
                fit: BoxFit.cover, // Adjust the fit as needed
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFCFDEF3),
                    Color.fromARGB(255, 161, 217, 255),
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      news.blog.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      news.blog.desc,
                      style: const TextStyle(fontSize: 13, color: Colors.black),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
