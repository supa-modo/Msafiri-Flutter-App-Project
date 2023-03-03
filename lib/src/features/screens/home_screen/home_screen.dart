import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../constants/constants.dart';
import '../../../size_config/size_config.dart';
import 'components/body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Color.fromARGB(197, 17, 17, 17)
          : const Color.fromARGB(235, 203, 212, 245),
      appBar: AppBar(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Color.fromARGB(197, 17, 17, 17)
            : const Color.fromARGB(235, 188, 197, 229),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Theme.of(context).brightness == Brightness.dark
              ? Color.fromARGB(197, 27, 27, 27)
              : Color.fromARGB(235, 180, 187, 212),
          statusBarIconBrightness:
              Theme.of(context).brightness == Brightness.dark
                  ? Brightness.light
                  : Brightness.dark,
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
          fontSize: getScreenWidth(22),
          fontWeight: FontWeight.bold,
          color: appPrimaryColor,
        ),
        title: Column(
          children: [
            Text(
              'Hello ${FirebaseAuth.instance.currentUser?.displayName?.split(" ")[0] ?? "'User'"}',
              style: TextStyle(
                  fontSize: getScreenWidth(22),
                  color: const Color.fromARGB(255, 83, 82, 82)),
            ),
            SizedBox(height: getScreenWidth(7)),
            Text(
              "logged in as passenger/operator",
              style: TextStyle(
                  fontSize: getScreenWidth(12),
                  fontWeight: FontWeight.w500,
                  color: const Color.fromARGB(255, 100, 99, 99)),
            )
          ],
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: const Body(),
    );
  }
}
