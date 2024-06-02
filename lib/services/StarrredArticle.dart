import 'dart:async';

class StarredArticles {
  static List<Map<String, dynamic>> _starredArticles = [];

  static void addArticle(Map<String, dynamic> article) {
    _starredArticles.add(article);
  }
  

  Future<void> addArticleToFireBase () async {
    
  }

  static void removeArticle(Map<String, dynamic> article) {
    _starredArticles.removeWhere((item) => item['title'] == article['title']);
  }

  static List<Map<String, dynamic>> getArticles() {
    return _starredArticles;
  }
}
