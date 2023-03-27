import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';
import 'package:project_x/firebase_options.dart';
import 'package:project_x/src/constants/constants.dart';
import 'package:project_x/src/constants/theme.dart';
import 'package:project_x/src/services/auth_repository.dart';
import 'package:project_x/src/size_config/size_config.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'src/features/screens/new_trip/location.dart';

void main() {
  MpesaFlutterPlugin.setConsumerKey(consumerKey);
  MpesaFlutterPlugin.setConsumerSecret(consumerSecret);

  SharedPreferences.setMockInitialValues({});
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(AuthRepository()));
  runApp(
    ChangeNotifierProvider(
      create: (_) => LocationProvider(),
      child: const MyApp(),
    ),
  );
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
      // home: SignInScreen(),
      home: Center(
        child: SizedBox(
            width: getScreenWidth(25),
            height: getScreenHeight(25),
            child: CircularProgressIndicator(color: appPrimaryColor)),
      ),
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
