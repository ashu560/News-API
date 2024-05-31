// lib/controllers/news_controller.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsController {
  Future<List<Map<String, dynamic>>> apicall() async {
    final response = await http.get(
      Uri.parse(
          'https://newsapi.org/v2/everything?q=apple&from=2024-05-29&to=2024-05-29&sortBy=popularity&apiKey=3781440623274e3baa7267e719aa65ca'),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData.containsKey('articles')) {
        return List<Map<String, dynamic>>.from(
          responseData['articles'],
        );
      } else {
        return [];
      }
    } else {
      throw Exception('Failed to load news');
    }
  }
}
