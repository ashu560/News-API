// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class ArticleDetailedWidget extends StatelessWidget {
  final Map<String, dynamic> newsItem;

  const ArticleDetailedWidget({super.key, required this.newsItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Source: ' + newsItem['source']['name']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (newsItem['urlToImage'] != null)
              Image.network(
                newsItem['urlToImage'],
              ),
            Padding(
              padding: const EdgeInsets.only(right: 20.0, top: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Published Date: ',
                    style: TextStyle(color: Colors.blueGrey),
                  ),
                  Text(
                    DateFormat('yyyy-MM-dd – kk:mm').format(
                      DateTime.parse(newsItem['publishedAt'] ?? ''),
                    ),
                    style: TextStyle(color: Colors.blueGrey),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Text(
              newsItem['title'] ?? 'No Title',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              newsItem['description'] ?? 'No Description',
              style: TextStyle(fontSize: 16),
            ),
            Divider(
              color: Colors.blueGrey,
              thickness: 2,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Author: ',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.blueGrey,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      newsItem['author'] ?? 'No content',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
