// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Map<String, dynamic>> newsList = [];
  late bool isLoading = false;

  Future<void> apicall() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(
        Uri.parse(
            'https://newsapi.org/v2/everything?q=apple&from=2024-05-29&to=2024-05-29&sortBy=popularity&apiKey=3781440623274e3baa7267e719aa65ca'),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData.containsKey('articles')) {
          setState(() {
            newsList =
                List<Map<String, dynamic>>.from(responseData['articles']);
          });
        } else {
          setState(() {
            newsList = [];
          });
        }
      }
    } catch (e) {
      // Handle error
      setState(() {
        newsList = [];
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    apicall();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 60,
                    right: 10,
                    left: 10,
                  ),
                  child: Container(
                    alignment: AlignmentDirectional.center,
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.amber.withOpacity(0.4),
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    child: const Text(
                      "Trending Bulletin",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                        fontSize: 32,
                      ),
                    ),
                  ),
                ),
                isLoading
                    ? Center(
                        child: const CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: newsList.length,
                        itemBuilder: (context, index) {
                          final newsItem = newsList[index];
                          final articleImg = newsItem['urlToImage'] ?? '';
                          return InkWell(
                            onTap: () {},
                            child: Column(
                              children: [
                                Container(
                                  height: 350,
                                  width: 350,
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(30),
                                    ),
                                    image: articleImg.isNotEmpty
                                        ? DecorationImage(
                                            image: NetworkImage(articleImg),
                                            fit: BoxFit.cover,
                                            opacity: 0.5,
                                          )
                                        : null,
                                  ),
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      Text(
                                        newsItem['title'] ?? '',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 22,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        newsItem['description'] ?? '',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Second Page...!'),
      ),
    );
  }
}
