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
) async {
  CollectionReference StarrredAticles =
      FirebaseFirestore.instance.collection('StarredArticles');

  try {
    DocumentReference article = await StarrredAticles.add(
      {
        'title': title,
        'urlToImage': urlToImage,
        'publishedAt': publishedAt,
        'description': description,
        'author': author,
        'url': url,
      },
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Not able to mark it as Star.'),
      ),
    );
  }

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Starred Success'),
    ),
  );
}

final Stream<QuerySnapshot> NewsAticle =
    FirebaseFirestore.instance.collection('StarredArticles').snapshots();
