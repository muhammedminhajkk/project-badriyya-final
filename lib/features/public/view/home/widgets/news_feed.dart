import 'package:flutter/material.dart';

class NewsFeed extends StatelessWidget {
  const NewsFeed({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        children: [
          const Expanded(
            flex: 17,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "ബദ്രിയ്യ നെഡിയനാട് സമ്മേളനം",
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                ),
                Text(
                  "മേയ് 02. 03. 04",
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                ),
                Text(
                  "നരിക്കുനി: നെഡിയനാട് ബദ്രിയ വാര്ഷിക സമ്മേളനം \"ഗ്രാറ്റോണിയം\" 2025 മേയ് 2,3,4 തീയതികളിൽ കാർക്കുളം ദർസിൽ നടക്കും. സി.അബ്ദുറഹ്മാൻ..",
                  style: TextStyle(fontSize: 9, color: Colors.black),
                  maxLines: 2, // Limiting the text to 2 lines
                  // overflow: TextOverflow
                  //     .ellipsis, // Adding ellipsis if the text overflows
                  softWrap: true, // Allowing the text to wrap
                ),
                Row(
                  children: [
                    Expanded(child: SizedBox()),
                    Text(
                      "Read More",
                      style: TextStyle(fontSize: 9, color: Colors.blue),
                    )
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 8,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/newsfeed.png"),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
