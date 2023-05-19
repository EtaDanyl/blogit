import 'package:blogit/auth.dart';
import 'package:flutter/material.dart';
import 'package:blogit/pages/start_page.dart';
import 'package:blogit/pages/home_page.dart';

class CurrentUser extends StatefulWidget {
  const CurrentUser({Key? key}) : super(key: key);

  @override
  State<CurrentUser> createState() => _CurrentUserState();
}

class _CurrentUserState extends State<CurrentUser> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const HomePage();
        } else {
          return const StartPage();
        }
      }
    );
  }
}
