import 'package:flutter/material.dart';

import '../../../size_config/size_config.dart';

class Forgot_passwordScreen {
  static Future<dynamic> forgot_bottomSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: ((context) => Container(
              padding: EdgeInsets.all(getScreenWidth(30)),
              child: Column(children: [
                Text(
                  "Choose one of the options below to reset your account password",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: getScreenWidth(21),
                    color: Color.fromARGB(255, 87, 86, 86),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: getScreenHeight(30)),
                GestureDetector(
                  onTap: (() {}),
                  child: Container(
                    padding: EdgeInsets.all(getScreenWidth(15)),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(getScreenWidth(12)),
                        color: Color.fromARGB(174, 206, 204, 204)),
                    child: Row(
                      children: [
                        Icon(
                          Icons.mail_outline_rounded,
                          size: getScreenWidth(40),
                        ),
                        SizedBox(width: getScreenWidth(16)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Email",
                              style: TextStyle(
                                fontSize: getScreenWidth(18),
                                color: Color.fromARGB(255, 43, 42, 42),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Reset password via Email Verification",
                              style: TextStyle(
                                  fontSize: getScreenWidth(14),
                                  color: Color.fromARGB(255, 105, 104, 104)),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: getScreenHeight(20)),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.all(getScreenWidth(15)),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(getScreenWidth(12)),
                        color: Color.fromARGB(174, 206, 204, 204)),
                    child: Row(
                      children: [
                        Icon(
                          Icons.mobile_friendly_rounded,
                          size: getScreenWidth(40),
                        ),
                        SizedBox(width: getScreenWidth(13)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Phone Verification",
                              style: TextStyle(
                                fontSize: getScreenWidth(18),
                                color: Color.fromARGB(255, 43, 42, 42),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Reset password via Phone Verification",
                              style: TextStyle(
                                  fontSize: getScreenWidth(14),
                                  color: Color.fromARGB(255, 105, 104, 104)),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ]),
            )));
  }
}
