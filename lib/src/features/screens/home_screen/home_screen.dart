import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../size_config/size_config.dart';
import 'components/body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(235, 203, 212, 245),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
          fontSize: getScreenWidth(22),
          fontWeight: FontWeight.bold,
          color: appPrimaryColor,
        ),
        title: Column(
          children: [
            Text(
              'Hello "User"',
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
