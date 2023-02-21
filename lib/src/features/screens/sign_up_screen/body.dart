import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../size_config/size_config.dart';
import 'account_text.dart';
import 'sign_up_form.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        // padding: EdgeInsets.symmetric(horizontal: getScreenWidth(20)),
        padding: EdgeInsets.symmetric(horizontal: getScreenWidth(20)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // SizedBox(height: SizeConfig.screenHeight * 0.0005),
              SizedBox(height: getScreenHeight(10)),
              Text(
                "Create Your Account",
                style: headingStyle,
              ),
              const Text(
                "Fill in your details below to continue",
                textAlign: TextAlign.center,
              ),
              const SignUpForm(),
              SizedBox(height: getScreenHeight(10)),
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
                        width: getScreenWidth(18),
                        height: getScreenHeight(18),
                      ),
                      label: Text(
                        "Sign Up with Google",
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
                        "Sign Up with Twitter",
                        style: TextStyle(
                            color: Color.fromARGB(255, 150, 148, 148)),
                      )),
                ),
              ),
              SizedBox(height: getScreenHeight(15)),
              const AccountText(),
            ],
          ),
        ),
      ),
    );
  }
}
