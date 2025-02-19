import 'package:flutter/material.dart';

class GradientText extends StatelessWidget {
  final String text;
  final double size;

  const GradientText(this.text, {super.key, this.size = 20});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return const LinearGradient(
          colors: <Color>[
            Color.fromARGB(255, 4, 70, 117),
            Color(0xFF00D2FF),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(bounds);
      },
      child: Text(
        text,
        style: TextStyle(
          fontSize: size,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
