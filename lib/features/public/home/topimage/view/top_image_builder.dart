import 'dart:async';

import 'package:badriyya/features/public/home/topimage/controller/banner_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TopImageBuilder extends ConsumerStatefulWidget {
  const TopImageBuilder({super.key});

  @override
  TopImageBuilderState createState() => TopImageBuilderState();
}

class TopImageBuilderState extends ConsumerState<TopImageBuilder> {
  final PageController _pageController = PageController(viewportFraction: 1);
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    // Start the timer for automatic scrolling
    _timer = Timer.periodic(const Duration(seconds: 7), (Timer timer) {
      final images = ref
          .read(bannerProvider)
          .maybeWhen(data: (data) => data, orElse: () => []);
      if (images.isNotEmpty) {
        _currentPage++;
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
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
    final bannerAsync = ref.watch(bannerProvider);

    return bannerAsync.when(
      data: (imageUrls) {
        if (imageUrls.isEmpty) {
          return const Center(child: Text("No banners found"));
        }

        return Stack(
          children: [
            
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              child: PageView.builder(
                controller: _pageController,
                physics:
                    const NeverScrollableScrollPhysics(), // Disable manual scrolling
                itemBuilder: (context, index) {
                  final cardIndex =
                      index % imageUrls.length; // Infinite loop logic
                  final url =
                      "https://badriyya.in/img/banners/${imageUrls[cardIndex]}";

                  return Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(url),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
            Center(child: Image.asset("assets/Logo.png", height: 100)),
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.transparent,
                      Color.fromARGB(180, 34, 139, 34), // Forest Green
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => const Center(child: Text("Failed to load banners")),
    );
  }
}
