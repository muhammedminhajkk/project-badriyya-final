import 'package:flutter/material.dart';
import 'dart:async';

import 'package:project_badriyya/features/public/home/view/widgets/card_widget.dart';

class HighLights extends StatefulWidget {
  const HighLights({super.key});

  @override
  HighLightsState createState() => HighLightsState();
}

class HighLightsState extends State<HighLights> {
  PageController _pageController = PageController(viewportFraction: 0.7);
  int _currentPage = 1;
  Timer? _timer;

  final List<Widget> _cards = [
    const CardWidget(image: "higlight1", title: "Documentary"),
    const CardWidget(image: "higlight2", title: "Documentary"),
  ];

  @override
  void initState() {
    super.initState();

    _pageController = PageController(
      initialPage: _currentPage,
      viewportFraction: 0.7,
    );

    _timer = Timer.periodic(const Duration(seconds: 6), (Timer timer) {
      _currentPage++;
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      itemBuilder: (context, index) {
        final cardIndex = index % _cards.length;
        return _cards[cardIndex];
      },
    );
  }
}
