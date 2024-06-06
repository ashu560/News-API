// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:boilerplate/services/StarrredArticle.dart';
import 'package:boilerplate/services/firebase_functions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

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
            // onPressed: toggleStarred,
            onPressed: () {
              addStarredArticle(
                context,
                widget.newsItem['title'] ?? '',
                widget.newsItem['urlToImage'] ?? '',
                widget.newsItem['publishedAt'] ?? '',
                widget.newsItem['description'] ?? '',
                widget.newsItem['author'] ?? '',
                widget.newsItem['url'] ?? '',
              );
              setState(
                () {
                  isStarred = !isStarred;
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
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
              Divider(
                color: Colors.blueGrey,
                thickness: 2,
              ),
              InkWell(
                child: Text(
                  widget.newsItem['url'] ?? 'No content',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
                onTap: () async {
                  final url = widget.newsItem['url'];
                  if (url != null && url.isNotEmpty) {
                    final uri = Uri.parse(url);
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Could not launch $url',
                          ),
                        ),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'URL is null or empty',
                        ),
                      ),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
