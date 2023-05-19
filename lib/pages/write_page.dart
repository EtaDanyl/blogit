import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:blogit/color_palette.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WritePage extends StatelessWidget {
  WritePage({Key? key}) : super(key: key);



  final FirebaseAuth _auth = FirebaseAuth.instance;

  final controllerTitle = TextEditingController();
  final controllerText = TextEditingController();

  Future createBlog({required String title, required String text, required String author}) async {
    final docBlog = FirebaseFirestore.instance.collection('blogs').doc();
    final json = {
      'title' : title,
      'text' : text,
      'author' : author,
      'docID' : docBlog.id,
    };

    await docBlog.set(json);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.themeColor,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white,
        title: Text(
          'blog it',
          style: TextStyle(
            color: Palette.themeColor[600],
            fontSize: 48,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
            child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: 300,
                child: TextField(
                  controller: controllerTitle,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Title',
                  ),
                  cursorColor: Colors.black,
                ),
              ),
              const SizedBox(height: 20.0),
              SizedBox(
                width: 300,
                child: TextField(
                  controller: controllerText,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Body',
                  ),
                  maxLines: 17,
                  cursorColor: Colors.black,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 300.0,
                height: 40.0,
                child: ElevatedButton(
                  onPressed: () {
                    final title = controllerTitle.text;
                    final text = controllerText.text;
                    final author = _auth.currentUser?.email;

                    createBlog(title: title, text: text, author: author!);

                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Palette.themeColor[600]!)),
                  child: const Text(
                    'PUBLISH',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
