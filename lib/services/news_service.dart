import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article.dart';

class NewsService {
  static const String _baseUrl =
      'https://api.spaceflightnewsapi.net/v4/articles/?limit=20';

  Future<List<Article>> fetchArticles() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List results = data['results'];
      return results.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception('Gagal memuat berita (status ${response.statusCode})');
    }
  }
}
