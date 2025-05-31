import 'package:badriyya/features/public/home/newsfield/model/news_model.dart';
import 'package:badriyya/features/public/home/newsfield/view/full_news_page.dart';
import 'package:flutter/material.dart';

class NewsFeed extends StatelessWidget {
  final NewsItem news;
  const NewsFeed({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FullNewsPage(news: news)),
        );
      },
      child: Container(
        height: 120,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 8, spreadRadius: 2),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              flex: 17,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    news.blog.title,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    news.blog.dateModified.toString().substring(0, 11),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    news.blog.shortDesc,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,

                      // color: Color(0xFF00695C),
                      fontFamily: 'Goodnews',
                    ),
                    //  TextStyle(fontSize: 10, color: Colors.black),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  ),
                  const Row(
                    children: [
                      Expanded(child: SizedBox()),
                      Text(
                        "Read More",
                        style: TextStyle(fontSize: 9, color: Colors.blue),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 8,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      "https://badriyya.in/timthumb/image?src=/app/webroot/img/post/${news.blog.image}&q=80&a=c&zc=1&ct=1&w=490&h=295",
                    ),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
