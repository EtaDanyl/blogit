import 'package:flutter/material.dart';

class Palette {
  static const MaterialColor themeColor = MaterialColor(
    0xffddd0c8,
    // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xffc7bbb4), //10%
      100: Color(0xffb1a6a0), //20%
      200: Color(0xff9b928c), //30%
      300: Color(0xff857d78), //40%
      400: Color(0xff6f6864), //50%
      500: Color(0xff585350), //60%
      600: Color(0xff423e3c), //70%
      700: Color(0xff2c2a28), //80%
      800: Color(0xff161514), //90%
      900: Color(0xff000000), //100%
    },
  );
}
