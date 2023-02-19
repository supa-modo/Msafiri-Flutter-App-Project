import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_x/src/constants/constants.dart';
import 'package:project_x/src/features/screens/forgot_password_screen/forgot_password_Mail.dart';

import '../../../size_config/size_config.dart';

class Forgot_passwordScreen {
  static Future<dynamic> forgot_bottomSheet(BuildContext context) {
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(getScreenWidth(25))),
        context: context,
        builder: ((context) => Container(
              padding: EdgeInsets.all(getScreenWidth(30)),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Password reset!",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: getScreenWidth(28),
                        color: appPrimaryColor,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      "Choose one of the options below to reset your account password",
                      style: TextStyle(
                        fontSize: getScreenWidth(16),
                      ),
                    ),
                    SizedBox(height: getScreenHeight(30)),
                    GestureDetector(
                      onTap: (() {
                        Navigator.pop(context);
                        Get.to(() => const Forgot_password_Mail());
                      }),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: getScreenWidth(15),
                            vertical: getScreenHeight(20)),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(getScreenWidth(12)),
                            color: Color.fromARGB(174, 206, 204, 204)),
                        child: Row(
                          children: [
                            Icon(
                              Icons.mail_outline_rounded,
                              size: getScreenWidth(38),
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
                                      color:
                                          Color.fromARGB(255, 105, 104, 104)),
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
                        padding: EdgeInsets.symmetric(
                            horizontal: getScreenWidth(15),
                            vertical: getScreenHeight(20)),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(getScreenWidth(12)),
                            color: Color.fromARGB(174, 206, 204, 204)),
                        child: Row(
                          children: [
                            Icon(
                              Icons.mobile_friendly_rounded,
                              size: getScreenWidth(38),
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
                                      color:
                                          Color.fromARGB(255, 105, 104, 104)),
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
