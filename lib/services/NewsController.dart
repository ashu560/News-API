// lib/controllers/news_controller.dart
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class NewsController {
  final String? baseURL = dotenv.env["BASE_URL"];
  Future<List<Map<String, dynamic>>> NewsItems() async {
    final response = await http.get(
      Uri.parse(baseURL!),
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
