import 'package:flutter/material.dart';

class TopImageBuilder extends StatelessWidget {
  const TopImageBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [
        Image.asset("assets/building.png", fit: BoxFit.cover),
        Image.asset("assets/building.png", fit: BoxFit.cover),
        Image.asset("assets/building.png", fit: BoxFit.cover),
        Image.asset("assets/building.png", fit: BoxFit.cover),
        Image.asset("assets/building.png", fit: BoxFit.cover),
      ],
    );
  }
}
