import 'package:flutter/material.dart';

class ArticleWidget extends StatefulWidget {
  final List<Map<String, dynamic>> newsList;
  const ArticleWidget({super.key, required this.newsList});

  @override
  State<ArticleWidget> createState() => _ArticleWidgetState();
}

class _ArticleWidgetState extends State<ArticleWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Hero(
        tag: 'ArticleDetailedPage',
        child: Center(
          child: Text(''),
        ),
      ),
    );
  }
}
