import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:blogit/color_palette.dart';

class UpdatePage extends StatelessWidget {
  UpdatePage({Key? key}) : super(key: key);

  final controllerTitle = TextEditingController();
  final controllerText = TextEditingController();


  late String docID;
  late String title;
  late String text;

  Future updateBlog({required String title, required String text, required String documentID}) async {
    final docBlog = FirebaseFirestore.instance.collection('blogs').doc(docID);

    docBlog.update({
      'title' : title,
      'text' : text,
    });
  }


  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    title = args['title'] as String;
    text = args['text'] as String;
    docID = args['docID'] as String;

    controllerTitle.text = title;
    controllerText.text = text;

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

                    updateBlog(title: title, text: text, documentID: docID);

                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Palette.themeColor[600]!)),
                  child: const Text(
                    'UPDATE',
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
