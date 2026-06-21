class Article {
  final int id;
  final String title;
  final String summary;
  final String imageUrl;
  final String newsSite;
  final String publishedAt;
  final String url;

  Article({
    required this.id,
    required this.title,
    required this.summary,
    required this.imageUrl,
    required this.newsSite,
    required this.publishedAt,
    required this.url,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      summary: json['summary'] ?? '',
      imageUrl: json['image_url'] ?? '',
      newsSite: json['news_site'] ?? '',
      publishedAt: json['published_at'] ?? '',
      url: json['url'] ?? '',
    );
  }

  // Dipakai saat passing data artikel via Navigator (arguments)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'summary': summary,
      'imageUrl': imageUrl,
      'newsSite': newsSite,
      'publishedAt': publishedAt,
      'url': url,
    };
  }

  factory Article.fromMap(Map<String, dynamic> map) {
    return Article(
      id: map['id'] ?? 0,
      title: map['title'] ?? '',
      summary: map['summary'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      newsSite: map['newsSite'] ?? '',
      publishedAt: map['publishedAt'] ?? '',
      url: map['url'] ?? '',
    );
  }
}
