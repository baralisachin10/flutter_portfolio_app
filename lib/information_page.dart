import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:portfolio_app/display_info_page.dart';
import 'package:portfolio_app/utils/local_data_source.dart';

class InformationPage extends StatefulWidget {
  const InformationPage({super.key});

  @override
  State<InformationPage> createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _aboutYourSelfController =
      TextEditingController();
  final TextEditingController _skillsController = TextEditingController();

  final LocalDataSource localDataSource = LocalDataSource();

  // to get the image
  final ImagePicker picker = ImagePicker();

  XFile? file;
  getImagePicker() async {
    file = await picker.pickImage(source: ImageSource.gallery);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text('Fill your Details')),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              InkWell(
                onTap: () {
                  getImagePicker();
                },
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  height: 100,
                  width: 100,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                  ),
                  child: file == null
                      ? const SizedBox()
                      : Image.file(
                          File(file!.path),
                          fit: BoxFit.cover,
                        ),
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              // enter your name
              const Text(
                "Enter your name",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              // enter your email
              const Text(
                "Enter your email",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              // About your self
              const Text(
                "About Yourself",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _aboutYourSelfController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              // about skills
              const Text(
                "Skills",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _skillsController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_aboutYourSelfController.text == '' ||
                      _nameController.text == '' ||
                      _emailController.text == '' ||
                      _skillsController.text == '' ||
                      file == null) {
                    final snackBar =
                        SnackBar(content: Text("please fill the form."));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else {
                    Map<String, dynamic> data = {
                      'name': _nameController.text,
                      'email': _emailController.text,
                      'skills': _skillsController.text,
                      'about': _aboutYourSelfController.text,
                      'imagePath': file!.path,
                    };
                    final encodedData = jsonEncode(data);
                    localDataSource.storeInformation(encodedData);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DisplayInfoPage(
                                  name: _nameController.text,
                                  email: _emailController.text,
                                  aboutYourSelf: _aboutYourSelfController.text,
                                  skills: _skillsController.text,
                                  imagepath: file!.path,
                                )));
                  }
                  ;
                },
                child: Text('Submit'),
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(
                      const Size(double.infinity, 50)),
                ),
              )
            ]),
          )
        ],
      ),
    );
  }
}
