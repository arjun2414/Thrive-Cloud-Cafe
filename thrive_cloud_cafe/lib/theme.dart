import 'package:flutter/material.dart';
import 'package:thrive_cloud_cafe/colors.dart';

class CustomTheme {
  static ThemeData get originalTheme {
    return ThemeData(
        scaffoldBackgroundColor: tcc_color.PrimaryColor,
        appBarTheme: appBarTheme(),
//        textTheme: TextTheme(bodyText2: TextStyle(color: Colors.white)),
        inputDecorationTheme: inputDecorationTheme());
  }
}

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    borderSide: BorderSide(color: Colors.grey),
    gapPadding: 8,
  );

  return InputDecorationTheme(
    contentPadding: EdgeInsets.symmetric(horizontal: 35, vertical: 20),
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
      elevation: 0.0,
      backgroundColor: tcc_color.PrimaryColor,
      iconTheme: IconThemeData(color: Colors.white),
      textTheme: TextTheme(headline3: TextStyle(color: Colors.white)));
}
