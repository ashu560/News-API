// ignore_for_file: prefer_const_constructors

import 'package:boilerplate/Navigation%20Bar/navbar.dart';
import 'package:boilerplate/screens/Home.dart';
import 'package:boilerplate/screens/settings.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Trending Bulletin',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => NavBar(),
        '/second': (context) => SecondPage(),
      },
    );
  }
}
