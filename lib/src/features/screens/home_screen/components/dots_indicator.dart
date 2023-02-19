import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

import '../../../../constants/constants.dart';
import '../../../../size_config/size_config.dart';

class dots_indicator extends StatelessWidget {
  const dots_indicator({
    Key? key,
    required this.currentPageValue,
  }) : super(key: key);

  final int currentPageValue;

  @override
  Widget build(BuildContext context) {
    return DotsIndicator(
      dotsCount: 5,
      position: currentPageValue.toDouble(),
      decorator: DotsDecorator(
        // color: const Color.fromARGB(255, 117, 117, 117),
        color: const Color.fromARGB(255, 107, 107, 107),
        activeColor: appPrimaryColor,
        size: Size.square(getScreenHeight(7.0)),
        spacing: EdgeInsets.symmetric(horizontal: getScreenWidth(4.5)),
        activeSize: Size(getScreenWidth(18.0), getScreenHeight(9.0)),
        activeShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }
}
