import 'dart:convert';
import 'package:boilerplate/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> newsList = [];
  bool isLoading = false;

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
                    : Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: NewsContainerr(newsList: newsList),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
