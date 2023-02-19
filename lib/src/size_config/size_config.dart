import 'package:flutter/material.dart';

class SizeConfig {
  static double screenHeight = 0.0;
  static double screenWidth = 0.0;

  static void init(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
  }
}

//getting proportinate height as per screen size
double getScreenHeight(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight;
  return (inputHeight / 812.0) * screenHeight;
}

//getting the proportinate screenWidth as per screen size
double getScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth;
  return (inputWidth / 375.0) * screenWidth;
}
