import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_x/firebase_options.dart';
import 'package:project_x/src/constants/theme.dart';

import 'src/features/screens/sign_in_screen/sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  SharedPreferences.setMockInitialValues({});
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
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
