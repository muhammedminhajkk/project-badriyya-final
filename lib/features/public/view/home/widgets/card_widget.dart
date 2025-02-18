import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final String image;
  final String title;
  // final String description;

  const CardWidget({super.key, required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      height: 150,
      width: 250,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/$image.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0), // Add padding for better spacing
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Align text to the left
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              // const SizedBox(height: 8), // Add spacing
              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align items at the top
                children: [
                  // Wrap long text to avoid overflow
                  const Expanded(
                    child: Text(
                      "Dolor sit amet,consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                      style: TextStyle(color: Colors.white, fontSize: 8),
                      maxLines: 3,
                      overflow: TextOverflow
                          .ellipsis, // Add ellipsis if text overflows
                    ),
                  ),
                  const SizedBox(
                      width: 8), // Add spacing between text and button
                  Container(
                    height: 30,
                    width: 85,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.play_arrow, size: 16, color: Colors.black),
                        SizedBox(width: 4),
                        Text(
                          "Watch Now",
                          style: TextStyle(fontSize: 8, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
