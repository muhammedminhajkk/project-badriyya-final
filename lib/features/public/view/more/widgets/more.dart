import 'package:flutter/material.dart';

class More extends StatelessWidget {
  final String name;
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  const More(
      {super.key,
      required this.name,
      required this.icon,
      required this.backgroundColor,
      required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                width: double.infinity,
                // height: 60,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  size: 30,
                  color: iconColor,
                ),
              ),
            ),
          ),
          // const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Text(
              name,
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
