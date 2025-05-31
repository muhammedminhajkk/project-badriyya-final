import 'dart:async';

import 'package:badriyya/features/public/home/higlights/view/card_widget_builder.dart';
import 'package:badriyya/features/public/home/newsfield/view/news_feed_builder.dart';
import 'package:badriyya/features/public/home/topimage/view/top_image_builder.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const routePath = '/home';
  static bool hasShownSplash = false;

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _showBlueScreen = !HomePage.hasShownSplash;

  @override
  void initState() {
    super.initState();

    if (_showBlueScreen) {
      _runSplashAndFetchData();
    }
  }

  Future<void> _runSplashAndFetchData() async {
    try {
      await Future.wait([Future.delayed(const Duration(seconds: 3))]);

      if (mounted) {
        setState(() {
          _showBlueScreen = false;
          HomePage.hasShownSplash = true;
        });
      }
    } catch (e) {
      debugPrint('Error playing audio: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 25, child: TopImageBuilder()),
              SizedBox(height: 20),
              Expanded(flex: 14, child: HighLights()),
              Expanded(flex: 35, child: NewsFeedBuilder()),
            ],
          ),
          if (_showBlueScreen)
            AnimatedContainer(
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeInOut,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF0F2027),
                    Color(0xFF203A43),
                    Color(0xFF2C5364),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0.5, end: 1),
                  duration: const Duration(seconds: 3),
                  curve: Curves.easeInOutCubic,
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.scale(
                        scale: value,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Outer glow
                            Container(
                              width: 200,
                              height: 200,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color.fromARGB(
                                      50,
                                      255,
                                      255,
                                      255,
                                    ),
                                    blurRadius: 40 * value,
                                    spreadRadius: 15 * value,
                                  ),
                                ],
                              ),
                            ),
                            // Animated circular progress
                            SizedBox(
                              width: 130,
                              height: 130,
                              child: CircularProgressIndicator(
                                value: value,
                                strokeWidth: 6,
                                backgroundColor: Colors.white24,
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            ),
                            // Inner logo
                            Container(
                              width: 100,
                              height: 100,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 12,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              alignment: Alignment.center,
                              child: Image.asset(
                                "assets/iconlogo.png",
                                width: 50,
                                height: 50,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
