import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_x/src/features/screens/otp_verification_screen/otp_verification.dart';

import '../../../common_widgets/defaultButton.dart';
import '../../../constants/constants.dart';
import '../../../size_config/size_config.dart';
import '../sign_up_screen/sign_up.dart';
import 'forgot_bottomSheet.dart';
import 'sign_in_form.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: getScreenWidth(25)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: getScreenHeight(20)),
              // SizedBox(height: SizeConfig.screenHeight! * 0.0005),
              Container(
                width: getScreenWidth(100),
                height: getScreenWidth(100),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image(
                  image: AssetImage("assets/images/logo.png"),
                ),
              ),
              SizedBox(height: getScreenHeight(10)),
              Text(
                "Welcome Back",
                style: headingStyle,
              ),
              SizedBox(height: getScreenHeight(10)),
              Text(
                "Login with your registered email and password to continue",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: getScreenWidth(14)),
              ),
              SizedBox(height: getScreenHeight(25)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: getScreenWidth(5)),
                child: const SignInForm(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {},
                    // TODO : Add a new screen for phone number sign in
                    child: Text(
                      "Login with phone number",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: textButtonColor,
                          fontSize: getScreenWidth(13)),
                    ),
                  ),
                  SizedBox(height: getScreenHeight(5)),
                  TextButton(
                    onPressed: () {
                      Forgot_passwordScreen.forgot_bottomSheet(context);
                    },
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: textButtonColor,
                          fontSize: getScreenWidth(13)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: getScreenHeight(10)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: getScreenWidth(90)),
                child: DefaultButton(
                    text: "Sign In",
                    pressed: () {
                      Get.to(() => OtpVerification());
                    }),
              ),
              SizedBox(height: getScreenHeight(15)),
              Text(
                "Or",
                style: TextStyle(
                    fontSize: getScreenWidth(13),
                    color: Color.fromARGB(255, 100, 100, 100)),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: getScreenWidth(15)),
                child: SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                      onPressed: null,
                      icon: Image(
                        image: AssetImage("assets/images/google_logo.png"),
                        width: getScreenWidth(20),
                        height: getScreenHeight(20),
                      ),
                      label: Text(
                        "Sign In with Google",
                        style: TextStyle(
                            color: Color.fromARGB(255, 150, 148, 148)),
                      )),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: getScreenWidth(15)),
                child: SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                      onPressed: null,
                      icon: Image(
                        image: AssetImage("assets/images/twittw.png"),
                        width: getScreenWidth(22),
                        height: getScreenHeight(22),
                      ),
                      label: Text(
                        "Sign In with Twitter",
                        style: TextStyle(
                            color: Color.fromARGB(255, 150, 148, 148)),
                      )),
                ),
              ),
              SizedBox(height: getScreenHeight(20)),
              const NoAccountText(),
            ],
          ),
        ),
      ),
    );
  }
}

class NoAccountText extends StatelessWidget {
  const NoAccountText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account? ",
          style: TextStyle(fontSize: getScreenWidth(13)),
        ),
        GestureDetector(
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignUpScreen())),
            child: Text(
              "Sign Up ",
              style: TextStyle(
                  fontSize: getScreenWidth(13),
                  color: textButtonColor,
                  fontWeight: FontWeight.bold),
            ))
      ],
    );
  }
}
