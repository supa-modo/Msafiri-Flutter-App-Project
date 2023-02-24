import 'package:flutter/material.dart';

import '../../../common_widgets/defaultButton.dart';
import '../../../constants/constants.dart';
import '../../../services/auth_repository.dart';
import '../../../size_config/size_config.dart';
import 'forgot_bottomSheet.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  // bool _isLoading = false;
  final TextEditingController _emailField = TextEditingController();
  final TextEditingController _passwordField = TextEditingController();

  final formKey = GlobalKey<FormState>();
  late String email;
  late String password;

  @override
  void dispose() {
    super.dispose();
    _emailField.dispose();
    _passwordField.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getScreenWidth(10)),
            child:
                SizedBox(height: getScreenHeight(48), child: emailFormField()),
          ),
          SizedBox(height: getScreenHeight(15)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getScreenWidth(10)),
            child: SizedBox(
                height: getScreenHeight(48), child: passwordFormField()),
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
                  AuthRepository.instance.loginUserWithEmailAndPassword(
                      _emailField.text, _passwordField.text);
                }),
          ),
        ],
      ),
    );
  }

  TextFormField emailFormField() {
    return TextFormField(
        controller: _emailField,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        onSaved: (newValue) => email = newValue!,
        decoration: InputDecoration(
          labelStyle: TextStyle(
              fontSize: getScreenWidth(18),
              color: appPrimaryColor,
              fontWeight: FontWeight.bold),
          hintStyle: TextStyle(fontSize: getScreenWidth(13)),
          labelText: "Email",
          hintText: "Enter Your Email address",
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: appPrimaryColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: appPrimaryColor)),
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ));
  }

  TextFormField passwordFormField() {
    return TextFormField(
        cursorColor: appPrimaryColor,
        controller: _passwordField,
        keyboardType: TextInputType.visiblePassword,
        obscureText: true,
        textInputAction: TextInputAction.done,
        onSaved: (newValue) => password = newValue!,
        decoration: InputDecoration(
          labelStyle: TextStyle(
              fontSize: getScreenWidth(18),
              color: appPrimaryColor,
              fontWeight: FontWeight.bold),
          labelText: "Password",
          hintStyle: TextStyle(fontSize: getScreenWidth(13)),
          hintText: "Enter Your Password",
          suffixIcon: IconButton(
              onPressed: null,
              icon: Icon(
                Icons.remove_red_eye_sharp,
                size: getScreenWidth(21),
              )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: appPrimaryColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: appPrimaryColor)),
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ));
  }
}
