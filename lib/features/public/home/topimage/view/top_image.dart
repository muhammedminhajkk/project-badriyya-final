import 'package:flutter/material.dart';

class TopImage extends StatelessWidget {
  final String image;
  const TopImage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/$image"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
