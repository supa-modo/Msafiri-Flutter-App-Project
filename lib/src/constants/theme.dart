import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_x/src/constants/constants.dart';

ThemeData theme() {
  return ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    fontFamily: "Muli",
    textTheme: const TextTheme(
      bodyText1: TextStyle(color: appTextColor),
      bodyText2: TextStyle(color: appTextColor),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Color.fromARGB(197, 219, 219, 219),
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

ThemeData darkTheme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.black,
    fontFamily: "Muli",
    textTheme: const TextTheme(
      bodyText1: TextStyle(color: darkAppTextColor),
      bodyText2: TextStyle(color: darkAppTextColor),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black,
      elevation: 0,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Color.fromARGB(197, 17, 17, 17),
        statusBarIconBrightness: Brightness.light,
      ),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    brightness: Brightness.dark,
  );
}

AppBarTheme appBarTheme() {
  return const AppBarTheme(
    color: Colors.white,
    elevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Color.fromARGB(197, 219, 219, 219),
      statusBarIconBrightness: Brightness.dark,
    ),
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: appPrimaryColor,
    ),
  );
}

InputDecoration inputDeco(labeltext) {
  return InputDecoration(
    contentPadding: const EdgeInsets.only(top: 8, bottom: 8, left: 20),
    labelText: labeltext,
    labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: appPrimaryColor)),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: appPrimaryColor)),
  );
}
