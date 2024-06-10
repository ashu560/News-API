// ignore_for_file: use_build_context_synchronously, unused_local_variable
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Future<void> addStarredArticle(
    BuildContext context,
    String title,
    String urlToImage,
    String publishedAt,
    String description,
    String author,
    String url,
    String starred,
    ) async {
  CollectionReference starredArticles = FirebaseFirestore.instance.collection('StarredArticles');

  try {
    // Check if the article with the given title already exists
    QuerySnapshot existingArticles = await starredArticles.where('title', isEqualTo: title).get();

    if (existingArticles.docs.isEmpty) {
      // If the article does not exist, add it to the collection
      await starredArticles.add({
        'title': title,
        'urlToImage': urlToImage,
        'publishedAt': publishedAt,
        'description': description,
        'author': author,
        'url': url,
        'starred': starred,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Starred Success'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Article is already starred.'),
        ),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Not able to mark it as Star.'),
      ),
    );
  }
}

// To fetch the StarredArticles fom Firebase
final Stream<QuerySnapshot> newsArticle = FirebaseFirestore.instance
    .collection('StarredArticles')
    .where('starred', isEqualTo: 'starred')
    .snapshots();
