import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../size_config/size_config.dart';

class AccountText extends StatelessWidget {
  const AccountText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already have an account? ",
          style: TextStyle(fontSize: getScreenWidth(13)),
        ),
        GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Text(
              "Sign In ",
              style: TextStyle(
                  fontSize: getScreenWidth(13),
                  color: textButtonColor,
                  fontWeight: FontWeight.bold),
            ))
      ],
    );
  }
}
