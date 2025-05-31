import 'package:flutter/material.dart';

class More extends StatelessWidget {
  final String name;
  final String? image; // Make image optional
  final Color backgroundColor;
  final Color iconColor;
  final Widget root;

  const More({
    super.key,
    required this.name,
    this.image, // Optional parameter
    required this.backgroundColor,
    required this.iconColor,
    required this.root,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => root),
          );
        },
        // Shadow Container wraps the clipped card
        child: Container(
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(80, 44, 83, 100),
                blurRadius: 18,
                spreadRadius: 2,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(230), // 0.90 * 255 ≈ 230
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: backgroundColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child:
                            image != null
                                ? Padding(
                                  padding: const EdgeInsets.all(14.0),
                                  child: Image.asset(
                                    image!,
                                    fit: BoxFit.fitHeight,
                                  ),
                                )
                                : Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFF007A8A),
                                        Color(0xFF45A6B4),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.settings,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Text(
                      name,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
