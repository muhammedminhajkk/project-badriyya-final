class Advertisement {
  final String title;
  final String shortDesc;
  final String desc;
  final String image;
  final String url;

  Advertisement({
    required this.title,
    required this.shortDesc,
    required this.desc,
    required this.image,
    required this.url,
  });

  // Factory method to create an Advertisement object from nested JSON
  factory Advertisement.fromJson(Map<String, dynamic> json) {
    final data = json['Advertisement'] ?? {};
    return Advertisement(
      title: data['title'] ?? '',
      shortDesc: data['short_desc'] ?? '',
      desc: data['desc'] ?? '',
      image: data['image'] ?? '',
      url: data['url'] ?? '',
    );
  }

  // Convert Advertisement to JSON (flat structure for saving)
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'short_desc': shortDesc,
      'desc': desc,
      'image': image,
      'url': url,
    };
  }
}
