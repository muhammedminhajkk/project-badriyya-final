class BannerModel {
  final String title;
  final String banner;

  BannerModel({required this.title, required this.banner});

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    final bannerData = json['Banner'];
    return BannerModel(
      title: bannerData['title'],
      banner: bannerData['banner'],
    );
  }
}
