// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class ArticleDetailedWidget extends StatefulWidget {
  final Map<String, dynamic> newsItem;

  const ArticleDetailedWidget({super.key, required this.newsItem});

  @override
  State<ArticleDetailedWidget> createState() => _ArticleDetailedWidgetState();
}

class _ArticleDetailedWidgetState extends State<ArticleDetailedWidget> {
  bool isStarred = false;

  void toggleStarred() {
    setState(() {
      isStarred = !isStarred;
      if (isStarred) {
        // Add to starred articles
        StarredArticles.addArticle(widget.newsItem);
      } else {
        // Remove from starred articles
        StarredArticles.removeArticle(widget.newsItem);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Source: ' + widget.newsItem['source']['name']),
        actions: [
          IconButton(
            icon: Icon(isStarred ? Icons.star : Icons.star_border),
            onPressed: toggleStarred,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.newsItem['urlToImage'] != null)
              Image.network(
                widget.newsItem['urlToImage'],
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
                      DateTime.parse(widget.newsItem['publishedAt'] ?? ''),
                    ),
                    style: TextStyle(color: Colors.blueGrey),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Text(
              widget.newsItem['title'] ?? 'No Title',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              widget.newsItem['description'] ?? 'No Description',
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
                      widget.newsItem['author'] ?? 'No content',
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

class StarredArticles {
  static List<Map<String, dynamic>> _starredArticles = [];

  static void addArticle(Map<String, dynamic> article) {
    _starredArticles.add(article);
  }

  static void removeArticle(Map<String, dynamic> article) {
    _starredArticles.removeWhere((item) => item['title'] == article['title']);
  }

  static List<Map<String, dynamic>> getArticles() {
    return _starredArticles;
  }
}
