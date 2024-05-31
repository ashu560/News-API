// ignore_for_file: use_super_parameters, sized_box_for_whitespace, prefer_const_constructors

import 'package:flutter/material.dart';

class NewsContainerr extends StatelessWidget {
  final List<Map<String, dynamic>> newsList;

  const NewsContainerr({required this.newsList, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height, // or any other height
      width: MediaQuery.of(context).size.width, // or any other width
      child: ListView.builder(
        itemCount: newsList.length,
        itemBuilder: (context, index) {
          final newsItem = newsList[index];
          final articleImg = newsItem['urlToImage'] ?? '';

          return Card(
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(35.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 200, // or any other height
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(35.0),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(articleImg), // Placeholder image
                      fit: BoxFit.cover,
                    ),
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
          );
        },
      ),
    );
  }
}


  // @override
  // Widget build(BuildContext context) {
  //   return Container(
  //     child: ListView.builder(
  //         itemCount: newsList.length,
  //         itemBuilder: (context, index) {
  //           final newsItem = newsList[index];
  //           final articleImg = newsItem['urlToImage'] ?? '';

  //           return Card(
  //             elevation: 4.0,
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(15.0),
  //             ),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.stretch,
  //               children: [
  //                 Expanded(
  //                   child: Container(
  //                     decoration: BoxDecoration(
  //                       borderRadius: BorderRadius.vertical(
  //                         top: Radius.circular(15.0),
  //                       ),
  //                       image: DecorationImage(
  //                         image: NetworkImage(articleImg), // Placeholder image
  //                         fit: BoxFit.cover,
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           );
  //         }),
  //   );

    // return Card(
    //   elevation: 4.0,
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(15.0),
    //   ),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.stretch,
    //     children: [
    //       Expanded(
    //         child: Container(
    //           decoration: const BoxDecoration(
    //             borderRadius: BorderRadius.vertical(
    //               top: Radius.circular(15.0),
    //             ),
    //             image: DecorationImage(
    //               image: NetworkImage(newsList), // Placeholder image
    //               fit: BoxFit.cover,
    //             ),
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );

