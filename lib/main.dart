// import 'package:flutter/cupertino.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:portfolio_app/display_info_page.dart';
import 'package:portfolio_app/information_page.dart';
import 'package:portfolio_app/utils/local_data_source.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Navigation(),
    );
  }
}

class Navigation extends StatelessWidget {
  final LocalDataSource localDataSource = LocalDataSource();

  Navigation({super.key});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: localDataSource.getInformation(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final result = snapshot.data;
            if (result != '') {
              Map<String, dynamic> decodedData = jsonDecode(result!);
              return DisplayInfoPage(
                  name: decodedData['name'],
                  email: decodedData['email'],
                  aboutYourSelf: decodedData['about'],
                  skills: decodedData['skills'],
                  imagepath: decodedData['imagePath']);
            } else {
              return const HomePage();
            }
          }
          return Container();
        });
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Portfolio App'),
      ),
      body: Center(
          child: ElevatedButton(
        onPressed: () {
          //push to next page
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const InformationPage()));
        },
        child: const Text('Get Started'),
      )),
    );
  }
}
