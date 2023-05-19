import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:blogit/color_palette.dart';
import 'package:blogit/blog_class.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  Stream<List<Blog>> readBlog() => FirebaseFirestore.instance
      .collection('blogs')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Blog.fromJson(doc.data())).toList());

  Widget buildBlog(BuildContext context, Blog blog) => Card(
        child: ListTile(
          onTap: () {
            Navigator.pushNamed(context, '/read', arguments: {
              'title': blog.title,
              'text': blog.text,
              'author': blog.author,
            });
          },
          leading: const CircleAvatar(
            backgroundImage: AssetImage('assets/dog.JPG'),
            radius: 30.0,
          ),
          title: Text(blog.title),
          subtitle: Text(blog.author),
          isThreeLine: true,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.themeColor,
      appBar: AppBar(
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
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/profile');
          },
          icon: const Icon(Icons.account_circle_outlined),
          iconSize: 40.0,
          color: Palette.themeColor[600],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/search');
            },
            icon: const Icon(Icons.search),
            iconSize: 40,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.create),
        onPressed: () {
          Navigator.pushNamed(context, '/write');
        },
      ),
      body: StreamBuilder<List<Blog>>(
        stream: readBlog(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final blogs = snapshot.data!;

            return Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                child: ListView(
                  children:
                      blogs.map((blog) => buildBlog(context, blog)).toList(),
                ),
              ),
            );
          } else {
            return Text(snapshot.error.toString());
          }
        },
      ),
    );
  }
}
