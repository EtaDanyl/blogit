import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:blogit/pages/start_page.dart';
import 'package:blogit/pages/login_page.dart';
import 'package:blogit/pages/home_page.dart';
import 'package:blogit/pages/search_page.dart';
import 'package:blogit/pages/write_page.dart';
import 'package:blogit/pages/read_page.dart';
import 'package:blogit/pages/update_page.dart';
import 'package:blogit/pages/profile_page.dart';
import 'package:blogit/color_palette.dart';
import 'package:blogit/current_user.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Palette.themeColor,
      fontFamily: 'Bahoo',
    ),
    initialRoute: '/',
    routes: {
      '/': (context) => const CurrentUser(),
      '/start': (context) => const StartPage(),
      '/login': (context) => const LoginPage(),
      '/home': (context) => const HomePage(),
      '/search': (context) => const SearchPage(),
      '/write': (context) => WritePage(),
      '/update': (context) => UpdatePage(),
      '/read': (context) => const ReadPage(),
      '/profile': (context) => const ProfilePage(),
    },
  ));
}
