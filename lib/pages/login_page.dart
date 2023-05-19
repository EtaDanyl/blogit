import 'package:blogit/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:blogit/color_palette.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:blogit/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errorMessage = '';
  bool isLogin = true;
  bool success = false;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);
      success = true;
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);
      success = true;
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Widget _entryField(
    String title,
    TextEditingController controller,
  ) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        filled: true,
        fillColor: Colors.white,
      ),
      cursorColor: Colors.black,
    );
  }

  Widget _errorMessage() {
    return Text(
      errorMessage == '' ? '' : '$errorMessage',
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: Colors.red,
      ),
    );
  }

  Widget _submitButton() {
    return ElevatedButton(
      onPressed: () async {
        //isLogin ? signInWithEmailAndPassword() : createUserWithEmailAndPassword();
        if (isLogin) {
          await
          signInWithEmailAndPassword();
        } else {
          await
          createUserWithEmailAndPassword();
        }
        if (success) {
          Navigator.pop(context);
          Navigator.pushNamed(context, '/home');
          success = false;
        }
      },
      style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(Palette.themeColor[600]!)),
      child: Text(
        isLogin ? 'Login' : 'Register',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15.0,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }

  Widget _loginOrRegisterButton() {
    return TextButton(
        onPressed: () {
          setState(() {
            isLogin = !isLogin;
          });
        },
        child: Text(
          isLogin ? 'Not a member? Register.' : 'Already a member? Log in.',
          style: TextStyle(color: Palette.themeColor[600], fontSize: 15.0),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.themeColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
            child: Column(
          children: <Widget>[
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: 300.0,
              child: Text(
                'Email:',
                style: TextStyle(
                  color: Palette.themeColor[600],
                  fontSize: 25,
                  fontWeight: FontWeight.normal,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(width: 300, child: _entryField('email', _controllerEmail)),
            SizedBox(
              width: 300.0,
              child: Text(
                'Password:',
                style: TextStyle(
                  color: Palette.themeColor[600],
                  fontSize: 25,
                  fontWeight: FontWeight.normal,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
                width: 300,
                child: _entryField('password', _controllerPassword)),
            _errorMessage(),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 300.0,
              height: 40.0,
              child: _submitButton(),
            ),
            _loginOrRegisterButton(),
          ],
        )),
      ),
    );
  }
}
