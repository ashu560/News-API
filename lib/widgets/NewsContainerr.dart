import 'package:flutter/material.dart';
import '../screens/ArticleDetailedPage.dart';

class NewsContainerr extends StatelessWidget {
  final List<Map<String, dynamic>> newsList;
  final int currentPage;
  NewsContainerr({required this.newsList, required this.currentPage, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int startIndex = currentPage * 10;
    int endIndex =
        (startIndex + 10 < newsList.length) ? startIndex + 10 : newsList.length;
    var currentArticles = newsList.sublist(startIndex, endIndex);

    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        itemCount: currentArticles.length,
        padding: const EdgeInsets.only(bottom: 250),
        itemBuilder: (context, index) {
          final newsItem = currentArticles[index];
          final articleImg = newsItem['urlToImage'] ?? '';

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ArticleDetailedWidget(newsItem: newsItem),
                ),
              );
            },
            child: Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(35.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (articleImg != null && articleImg.isNotEmpty)
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(35.0),
                      ),
                      child: Image.network(
                        articleImg,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/images/photo.png',
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    )
                  else
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(35.0),
                      ),
                      child: Image.asset(
                        'assets/images/photo.png',
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
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
    );
  }
}
