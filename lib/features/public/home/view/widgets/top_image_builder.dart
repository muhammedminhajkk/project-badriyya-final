import 'dart:async';

import 'package:flutter/material.dart';
import 'package:project_badriyya/features/public/home/view/widgets/top_image.dart';

class TopImageBuilder extends StatefulWidget {
  const TopImageBuilder({super.key});

  @override
  TopImageBuilderState createState() => TopImageBuilderState();
}

class TopImageBuilderState extends State<TopImageBuilder> {
  PageController _pageController = PageController(viewportFraction: 0.7);
  int _currentPage = 0;
  Timer? _timer;

  final List<Widget> images = [
    const TopImage(
      image: "building.png",
    ),
    const TopImage(
      image: "background.png",
    ),
  ];

  @override
  void initState() {
    super.initState();

    _pageController = PageController(
      initialPage: _currentPage,
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
        final cardIndex = index % images.length;
        return images[cardIndex];
      },
    );
  }
}
