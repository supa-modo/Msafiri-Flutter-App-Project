import 'package:flutter/material.dart';
import 'package:project_x/src/constants/theme.dart';

import 'src/features/screens/sign_in_screen/sign_in.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme(),
      darkTheme: darkTheme(),
      // themeMode: ThemeMode.dark,
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: SignInScreen(),
    );
  }
}

class MyAppHome extends StatelessWidget {
  const MyAppHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
