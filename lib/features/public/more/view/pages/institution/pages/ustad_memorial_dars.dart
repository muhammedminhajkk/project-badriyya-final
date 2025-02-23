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
                color: const Color.fromARGB(255, 0, 88, 132),
                child: Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back_rounded)),
                    ],
                  ),
                ),
              ),
              const Padding(
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
                      style: TextStyle(fontSize: 13, color: Colors.black54),
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
          Column(
            children: [
              const SizedBox(
                height: 230,
              ),
              Center(
                child: Container(
                  height: 40,
                  width: 270,
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 19, 111, 99),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: const Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Contact"),
                        SizedBox(width: 8), // Spacing before divider
                        Padding(
                          padding: EdgeInsets.only(top: 4.0, bottom: 4),
                          child: VerticalDivider(
                            color: Colors.white,
                            thickness: 2,
                            width: 20,
                          ),
                        ),
                        SizedBox(width: 8), // Spacing after divider
                        Text("Gallery"),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
