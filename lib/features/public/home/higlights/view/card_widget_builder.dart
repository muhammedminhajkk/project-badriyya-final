import 'dart:async';

import 'package:badriyya/features/public/home/higlights/controller/highlite_controller.dart';
import 'package:badriyya/features/public/home/higlights/view/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HighLights extends ConsumerStatefulWidget {
  const HighLights({super.key});

  @override
  HighLightsState createState() => HighLightsState();
}

class HighLightsState extends ConsumerState<HighLights> {
  late final PageController _pageController;
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _currentPage = 1000; // Set high to allow both side scroll
    _pageController = PageController(
      initialPage: _currentPage,
      viewportFraction: 0.7,
    );

    _pageController.addListener(() {
      final newPage = _pageController.page?.round() ?? _currentPage;
      if (newPage != _currentPage) {
        _currentPage = newPage;
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _timer = Timer.periodic(const Duration(seconds: 6), (Timer timer) {
        final ads = ref.read(adsControllerProvider);
        if (ads.isNotEmpty) {
          _currentPage++;
          _pageController.animateToPage(
            _currentPage,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      });
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
    final advertisements = ref.watch(adsControllerProvider);

    if (advertisements.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return Stack(
      children: [
        Positioned(
          top: -0,
          left: 180,
          child: Container(
            width: 280,
            height: 150,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  Color.fromARGB(255, 121, 232, 254),
                  Color.fromARGB(229, 255, 255, 255),
                ],
                radius: 0.5,
              ),
            ),
          ),
        ),
        PageView.builder(
          controller: _pageController,
          itemBuilder: (context, index) {
            final ad = advertisements[index % advertisements.length];
            return CardWidget(
              image: ad.image,
              title: ad.title,
              description: ad.shortDesc,
              url: ad.url,
            );
          },
        ),
      ],
    );
  }
}
