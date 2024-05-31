// ignore_for_file: prefer_const_constructors

import 'package:boilerplate/screens/ArticleDetailedPage.dart';
import 'package:flutter/material.dart';

class StarredArticlesPage extends StatelessWidget {
  const StarredArticlesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final starredArticles = StarredArticles.getArticles();

    return Scaffold(
      appBar: AppBar(
        title: Text('Starred Articles'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 20,
          right: 10,
          left: 10,
        ),
        child: ListView.builder(
          itemCount: starredArticles.length,
          itemBuilder: (context, index) {
            final newsItem = starredArticles[index];
            final articleImg = newsItem['urlToImage'] ?? '';

            return GestureDetector(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) =>
                //         ArticleDetailedWidget(newsItem: newsItem),
                //   ),
                // );
              },
              child: Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 200, // or any other height
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(35.0),
                        ),
                        image: DecorationImage(
                          image: NetworkImage(articleImg), // Placeholder image
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        newsItem['title'] ?? '',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
