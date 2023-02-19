import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../size_config/size_config.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final TextEditingController _emailField = TextEditingController();
  final TextEditingController _passwordField = TextEditingController();

  final formKey = GlobalKey<FormState>();
  late String email;
  late String password;

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
