import 'package:flutter/material.dart';
import 'package:blogit/color_palette.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:blogit/blog_class.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();
  String keyword = '';

  Stream<List<Blog>> searchBlog() => FirebaseFirestore.instance
      .collection('blogs')
      .where('title', isEqualTo: keyword)
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
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.create),
        onPressed: () {
          Navigator.pushNamed(context, '/write');
        },
      ),
      body: SafeArea(
            child: Column(
          children: <Widget>[
            const SizedBox(height: 20.0),
            SizedBox(
              width: 300,
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  prefixIconColor: Palette.themeColor[600],
                  border: const OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
                cursorColor: Colors.black,
                controller: searchController,
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    keyword = searchController.text;
                  });
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Palette.themeColor[600]!)),
                child: const Text('Search', style: TextStyle(color: Colors.white))
            ),
            Expanded(
              child: StreamBuilder<List<Blog>>(
                stream: searchBlog(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final blogs = snapshot.data!;

                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 50.0),
                        child: ListView(
                          children: blogs
                              .map((blog) => buildBlog(context, blog))
                              .toList(),
                        ),
                      ),
                    );
                  } else {
                    return const Text('No results found.');
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
