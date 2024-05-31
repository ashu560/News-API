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

  final NewsController _newsController = NewsController();

  Future<void> apicall() async {
    setState(() {
      isLoading = true;
    });

    try {
      final fetchedNews = await _newsController.apicall();
      if (mounted) {
        setState(() {
          newsList = fetchedNews;
        });
      }
    } catch (e) {
      // Handle error appropriately
      if (mounted) {
        setState(() {
          newsList = [];
        });
      }
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
