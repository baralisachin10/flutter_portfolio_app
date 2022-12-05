import 'dart:io';

import 'package:flutter/material.dart';
import 'package:portfolio_app/main.dart';
import 'package:portfolio_app/utils/local_data_source.dart';

class DisplayInfoPage extends StatelessWidget {
  final String name;
  final String email;
  final String aboutYourSelf;
  final String skills;
  final String imagepath;

  const DisplayInfoPage(
      {required this.name,
      required this.email,
      required this.aboutYourSelf,
      required this.skills,
      required this.imagepath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Portfolio'),
        actions: [
          IconButton(
              onPressed: () {
                LocalDataSource.clearInformation().then((value) =>
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()),
                        (route) => false));
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                height: 100,
                width: 100,
                child: Image.file(
                  File(imagepath),
                  fit: BoxFit.cover,
                ),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                children: [Text(name), Text(email)],
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'About Me',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            aboutYourSelf,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'skills',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            skills,
            style: TextStyle(fontSize: 16),
          )
        ]),
      ),
    );
  }
}
