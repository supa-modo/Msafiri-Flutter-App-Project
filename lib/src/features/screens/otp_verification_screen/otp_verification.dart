import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_x/src/features/screens/home_screen/home_screen.dart';

import '../../../constants/constants.dart';
import '../../../size_config/size_config.dart';
import 'otp_form.dart';

class OtpVerification extends StatelessWidget {
  const OtpVerification({super.key});

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
        title: const Text("Phone Verification"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: appPrimaryColor),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: getScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // SizedBox(height: SizeConfig.screenHeight! * 0.0005),
                SizedBox(height: getScreenWidth(30)),
                Text(
                  "Verification Code",
                  style: headingStyle,
                ),
                SizedBox(height: getScreenHeight(10)),
                const Text(
                  "Enter the verification code sent to \n +2547 12 123 123",
                  textAlign: TextAlign.center,
                ),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "Change Phone Number",
                      style: TextStyle(
                          fontSize: getScreenWidth(14),
                          color: appPrimaryColor,
                          fontWeight: FontWeight.bold),
                    )),
                const OtpForm(),

                SizedBox(height: getScreenHeight(20)),
                const Text("Didn't receive any code?"),
                SizedBox(height: getScreenHeight(10)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: getScreenWidth(15)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Resend code after: 1***"),
                      SizedBox(height: getScreenHeight(10)),
                      TextButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(174, 236, 236, 236)),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                          child: Text(
                            "Resend Code",
                            style: TextStyle(
                                fontSize: getScreenWidth(13),
                                color: appPrimaryColor,
                                fontWeight: FontWeight.bold),
                          )),
                    ],
                  ),
                ),
                SizedBox(height: getScreenHeight(40)),

                SizedBox(
                  width: getScreenWidth(170),
                  height: getScreenHeight(50),
                  child: TextButton(
                    onPressed: () {
                      Get.to(() => HomeScreen());
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 30, 117, 247)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25))),
                    ),
                    child: Text(
                      "Confirm",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: getScreenWidth(15),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
