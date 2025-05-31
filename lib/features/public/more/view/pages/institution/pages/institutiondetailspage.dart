import 'package:flutter/material.dart';

class InstitutionDetailPage extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  const InstitutionDetailPage({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Decorative circles (optional, remove if not needed)
          Positioned(
            // top: 50,
            left: -80,
            child: Container(
              width: 380,
              height: 380,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [Color.fromARGB(255, 121, 232, 254), Colors.white],
                  radius: 0.5,
                ),
              ),
            ),
          ),
          Positioned(
            top: 500,
            left: 100,
            child: Container(
              width: 380,
              height: 380,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [Color.fromARGB(255, 121, 232, 254), Colors.white],
                  radius: 0.5,
                ),
              ),
            ),
          ),
          CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF015D74),
                elevation: 0.5,
                pinned: true,
                expandedHeight: 210,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF015D74),
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        description,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black87,
                          height: 1.6,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
