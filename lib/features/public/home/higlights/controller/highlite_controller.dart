import 'package:badriyya/features/public/home/higlights/model/higlight_model.dart';
import 'package:badriyya/features/public/home/higlights/services/highlite_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final adsControllerProvider =
    StateNotifierProvider<HighLiteController, List<Advertisement>>(
      (ref) => HighLiteController(),
    );

class HighLiteController extends StateNotifier<List<Advertisement>> {
  final AdvertisementService _service = AdvertisementService();

  HighLiteController() : super([]) {
    loadCachedAndFetch();
  }

  Future<void> loadCachedAndFetch() async {
    // Load from cache first for immediate UI
    final cachedAds = await _service.loadCachedAdvertisements();
    if (cachedAds.isNotEmpty) {
      state = cachedAds;
    }

    // Then fetch fresh ads and update state & cache
    try {
      final freshAds = await _service.fetchAdvertisements();
      state = freshAds;
    } catch (e) {
      // Optionally handle API fetch error
    }
  }
}
