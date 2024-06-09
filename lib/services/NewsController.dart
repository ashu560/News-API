import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class NewsController {
  Future<List<Map<String, dynamic>>> NewsItems(DateTime pickedDate) async {
    final dateFormat = DateFormat('yyyy-MM-dd');
    final formattedDate = dateFormat.format(pickedDate);
    final String? baseURL = dotenv.env["BASE_URL"];
    final String? apiKey = dotenv.env["apiKey"];

    final urlWithDate =
        "${baseURL!}/v2/everything?q=apple&from=$formattedDate&to=$formattedDate&sortBy=popularity&apiKey=$apiKey";

    try {
      final response = await http.get(Uri.parse(urlWithDate));

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData.containsKey('articles')) {
          return List<Map<String, dynamic>>.from(responseData['articles']);
        } else {
          // Handle the case where 'articles' is not a key in the response data
          return [];
        }
      } else {
        // Handle non-200 responses
        print('Failed to load news articles');
        return [];
      }
    } on HandshakeException catch (e) {
      // Handle the HandshakeException
      print('HandshakeException caught: $e');
      // Return an empty list or a specific error indicator as needed
      return [];
    } catch (e) {
      // Handle other exceptions
      print('An error occurred: $e');
      return [];
    }
  }
}
