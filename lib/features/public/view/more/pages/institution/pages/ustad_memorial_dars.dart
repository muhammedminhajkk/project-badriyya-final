import 'package:flutter/material.dart';

class UstadMemorialDars extends StatelessWidget {
  const UstadMemorialDars({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 250,
                width: double.infinity,
                color: Colors.red, // Replacing the image with a color
              ),
              Padding(
                padding: EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16),
                    Text(
                      "C Usthad Memorial Dars",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                    SizedBox(height: 16),
                    Text(
                      "• 100+ Students\n"
                      "• 11+ Academic Staff\n"
                      "• 6+ Non-Teaching Staff",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 240,
            child: Container(
              color: Colors.green,
              child: Row(
                children: [Text("Contact"), Text("Gallery")],
              ),
            ),
          )
        ],
      ),
    );
  }
}
