import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../size_config/size_config.dart';
import 'body.dart';

class SignUpScreen extends StatelessWidget {
  static String routeName = "/signUp";
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
          fontSize: getScreenWidth(22),
          fontWeight: FontWeight.bold,
          color: appPrimaryColor,
        ),
        title: const Text("Sign Up"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: appPrimaryColor),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: const Body(),
    );
  }
}
