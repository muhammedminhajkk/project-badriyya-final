import 'package:badriyya/features/public/more/view/pages/Gallery/services/gallery_model.dart';
import 'package:badriyya/features/public/more/view/pages/Gallery/services/gallery_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final galleryControllerProvider =
    StateNotifierProvider<GalleryController, List<BannerModel>>(
      (ref) => GalleryController(),
    );

class GalleryController extends StateNotifier<List<BannerModel>> {
  final GalleryService _service = GalleryService();

  GalleryController() : super([]) {
    fetchGallery();
  }

  Future<void> fetchGallery() async {
    try {
      final gallery = await _service.fetchGallery();
      state = gallery;
    } catch (e) {
      throw Exception('Failed to fetch gallery: $e');
    }
  }
}
