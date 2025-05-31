import 'package:badriyya/features/public/gradient_text.dart';
import 'package:flutter/material.dart';

class ComingSoon extends StatelessWidget {
  final String tittle;
  const ComingSoon({super.key, required this.tittle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: GradientText(tittle),
      ),
      body: Container(
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
        child: Center(
          child: Container(
            width: 250,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  spreadRadius: 2,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Circular icon
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Color(0xFF007A8A), Color(0xFF45A6B4)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: const Icon(
                    Icons.settings,
                    size: 40,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 16),

                // "Coming Soon..!" text
                const Text(
                  "Coming Soon..!",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),

                const SizedBox(height: 8),

                // Divider line
                const Divider(
                  thickness: 1,
                  color: Colors.grey,
                  indent: 20,
                  endIndent: 20,
                ),

                const SizedBox(height: 8),

                // "Go Back" text button
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context); // Closes the current screen
                  },
                  child: const Text(
                    "Go Back",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF007A8A),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
