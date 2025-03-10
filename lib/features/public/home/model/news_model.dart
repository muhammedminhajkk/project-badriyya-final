class News {
  String status;
  List<NewsItem> news;

  News({
    required this.status,
    required this.news,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      status: json['status'],
      news: (json['data']['news'] as List)
          .map((item) => NewsItem.fromJson(item))
          .toList(),
    );
  }
}

class NewsItem {
  final Blog blog;
  final BlogCategory blogCategory;

  NewsItem({required this.blog, required this.blogCategory});

  factory NewsItem.fromJson(Map<String, dynamic> json) {
    return NewsItem(
      blog: Blog.fromJson(json['Blog']),
      blogCategory: BlogCategory.fromJson(json['BlogCategory']),
    );
  }
}

class Blog {
  final String id;
  final String title;
  final String shortDesc;
  final String desc;
  final String image;
  final String dateCreated;
  final String dateModified;
  final String block;

  Blog({
    required this.id,
    required this.title,
    required this.shortDesc,
    required this.desc,
    required this.image,
    required this.dateCreated,
    required this.dateModified,
    required this.block,
  });

  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      id: json['id'],
      title: json['title'],
      shortDesc: json['short_desc'],
      desc: json['desc'],
      image: json['image'],
      dateCreated: json['date_created'],
      dateModified: json['date_modified'],
      block: json['block'],
    );
  }
}

class BlogCategory {
  final String id;
  final String name;
  final String block;

  BlogCategory({
    required this.id,
    required this.name,
    required this.block,
  });

  factory BlogCategory.fromJson(Map<String, dynamic> json) {
    return BlogCategory(
      id: json['id'],
      name: json['name'],
      block: json['block'],
    );
  }
}
