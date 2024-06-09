// ignore_for_file: prefer_const_constructors

import 'package:boilerplate/services/NewsController.dart';
import 'package:boilerplate/widgets/NewsContainerr.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> newsList = [];
  bool isLoading = false;
  DateTime selectedDate = DateTime.now();
  // DateTime selectedDate = DateTime(2024, 06, 08);
  final NewsController newsController = NewsController();

  Future<void> apicall() async {
    setState(() {
      isLoading = true;
    });

    try {
      final fetchedNews = await newsController.NewsItems(selectedDate);
      if (mounted) {
        setState(() {
          newsList = fetchedNews;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          newsList = [];
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          "Trending Bulletin",
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                            fontSize: 32,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            final DateTime? dateTime = await showDatePicker(
                              context: context,
                              initialDate: selectedDate,
                              firstDate: DateTime(2024),
                              lastDate: DateTime(2025),
                            );

                            if (dateTime != null) {
                              setState(() {
                                selectedDate = dateTime;
                              });
                              await apicall(); // Fetch news for the selected date
                            }
                          },
                          child: Icon(
                            Icons.date_range_outlined,
                            color: Colors.amber,
                          ),
                        ),
                      ],
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
