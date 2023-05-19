import 'package:flutter/material.dart';
import 'package:blogit/color_palette.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:blogit/auth.dart';
import 'package:blogit/pages/start_page.dart';
import 'package:blogit/blog_class.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final User? user = Auth().currentUser;

  final Auth auth = Auth();

  Future<void> signOut() async {
    await auth.signOut();
  }

  Stream<List<Blog>> readBlog() => FirebaseFirestore.instance
      .collection('blogs')
      .where('author', isEqualTo: user!.email!)
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
      subtitle: Row(
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/update', arguments: {
                  'title': blog.title,
                  'text': blog.text,
                  'docID': blog.docID,
                });
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Palette.themeColor[600]!)),
              child: const Text('Edit', style: TextStyle(color: Colors.white))
          ),
          const SizedBox(width: 10.0),
          ElevatedButton(
              onPressed: () {
                final blogPost = FirebaseFirestore.instance
                    .collection('blogs')
                    .doc(blog.docID);

                setState(() {
                  blogPost.delete();
                });
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Palette.themeColor[600]!)),
              child: const Text('Delete', style: TextStyle(color: Colors.white))
          ),
        ],
      ),
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
        actions: [
          IconButton(
              onPressed: () {
                signOut;
                Navigator.of(context).popUntil((route) => route.isFirst);
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const StartPage()));
              },
              icon: const Icon(Icons.logout),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.create),
        onPressed: () {
          Navigator.pushNamed(context, '/write');
        },
      ),
      body: SafeArea(
        child: Center(
            child: Column(
          children: <Widget>[
            const SizedBox(height: 20.0),
            const CircleAvatar(
              backgroundImage: AssetImage('assets/dog.JPG'),
              radius: 100.0,
            ),
            Text(
              user!.email!,
              style: TextStyle(
                fontSize: 35.0,
                color: Palette.themeColor[600]!,
              ),
            ),
            Expanded(
              child: StreamBuilder<List<Blog>>(
                stream: readBlog(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final blogs = snapshot.data!;

                    return Center(
                      child: Padding(
                        padding:
                        const EdgeInsets.symmetric(vertical: 5.0, horizontal: 50.0),
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
            ),
          ],
        )),
      ),
    );
  }
}
