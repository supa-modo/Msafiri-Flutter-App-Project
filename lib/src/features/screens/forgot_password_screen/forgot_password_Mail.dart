import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_x/src/common_widgets/defaultButton.dart';
import 'package:project_x/src/constants/constants.dart';
import 'package:project_x/src/features/screens/home_screen/home_screen.dart';
import 'package:project_x/src/size_config/size_config.dart';

class Forgot_password_Mail extends StatelessWidget {
  const Forgot_password_Mail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
          fontSize: getScreenWidth(22),
          color: appPrimaryColor,
        ),
        title: const Text("Password Reset"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: appPrimaryColor),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: getScreenWidth(16), vertical: getScreenHeight(70)),
          child: Column(
            children: [
              Text("Forgot your password?", style: headingStyle),
              SizedBox(height: getScreenHeight(20)),
              Text(
                "Enter the email registered with your account to reset your password ",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: getScreenHeight(40)),
              Form(
                  child: Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: getScreenWidth(15)),
                    child: SizedBox(
                      height: getScreenHeight(48),
                      child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(fontSize: getScreenWidth(13)),
                            labelStyle: TextStyle(
                                fontSize: getScreenWidth(18),
                                color: appPrimaryColor,
                                fontWeight: FontWeight.bold),
                            labelText: "Email",
                            hintText: "Enter your registered email address",
                            // prefixIcon: Icon(Icons.mail_outline_rounded,
                            //     color: Color.fromARGB(174, 132, 132, 133)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:
                                    const BorderSide(color: appPrimaryColor)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:
                                    const BorderSide(color: appPrimaryColor)),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          )),
                    ),
                  ),
                  SizedBox(height: getScreenHeight(20)),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: getScreenWidth(60)),
                    child: SizedBox(
                      width: double.infinity,
                      height: getScreenHeight(47),
                      child: TextButton(
                        onPressed: () {
                          Get.to(() => HomeScreen());
                        },
                        child: Text("Next",
                            style: TextStyle(
                              fontSize: getScreenWidth(16),
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            )),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 50, 130, 250)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20))),
                        ),
                      ),
                    ),
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
