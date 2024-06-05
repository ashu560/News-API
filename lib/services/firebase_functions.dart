import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Future<void> addStarredArticle(BuildContext context, String StarArticle) async {
  CollectionReference StarrredAticles =
      FirebaseFirestore.instance.collection('StarredArticles');

  DocumentReference article =
      await StarrredAticles.add({'Starred Article': StarArticle});

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Starred Success')),
  );
}

final Stream<QuerySnapshot> NewsAticle =
    FirebaseFirestore.instance.collection('StarredArticles').snapshots();
