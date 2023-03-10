import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_x/src/features/models/user_models.dart';
import 'package:project_x/src/services/auth_repository.dart';

import '../../../common_widgets/defaultButton.dart';
import '../../../constants/constants.dart';
import '../../../size_config/size_config.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  late String name, phoneNumber, email;
  late String password;
  bool _isOperator = false;
  bool _isPassenger = false;

  final TextEditingController _emailField = TextEditingController();
  final TextEditingController _passwordField = TextEditingController();
  final TextEditingController _nameField = TextEditingController();
  final TextEditingController _phoneNumberField = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _emailField.dispose();
    _passwordField.dispose();
    _nameField.dispose();
    _phoneNumberField.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(SignUpController());

    return Form(
        autovalidateMode: AutovalidateMode.always,
        key: formKey,
        child: Column(children: [
          SizedBox(height: getScreenHeight(30)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getScreenWidth(10)),
            child:
                SizedBox(height: getScreenHeight(46), child: emailFormField()),
          ),
          SizedBox(height: getScreenHeight(20)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getScreenWidth(10)),
            child:
                SizedBox(height: getScreenHeight(46), child: nameFormField()),
          ),
          SizedBox(
            height: getScreenHeight(20),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getScreenWidth(10)),
            child: SizedBox(
                height: getScreenHeight(46), child: phoneNumberFormField()),
          ),
          SizedBox(
            height: getScreenHeight(20),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getScreenWidth(10)),
            child: SizedBox(
                height: getScreenHeight(46), child: passwordFormField()),
          ),
          SizedBox(
            height: getScreenHeight(10),
          ),
          Text(
            "Sign up as:",
            style: TextStyle(
                fontSize: getScreenWidth(14), fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getScreenWidth(25)),
            child: Row(
              children: <Widget>[
                Checkbox(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  value: _isOperator,
                  onChanged: (value) {
                    setState(() {
                      _isOperator = value!;
                      _isPassenger = !value;
                    });
                  },
                ),
                const Text("Operator"),
                SizedBox(width: getScreenWidth(50)),
                Checkbox(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  value: _isPassenger,
                  onChanged: (value) {
                    setState(() {
                      _isPassenger = value!;
                      _isOperator = !value;
                    });
                  },
                ),
                const Text("Passenger"),
              ],
            ),
          ),
          Text(
            "** By pressing the Sign Up button you agree to our terms and conditions **",
            style: TextStyle(
                fontSize: getScreenWidth(getScreenWidth(13)),
                fontStyle: FontStyle.italic),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: getScreenHeight(15),
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: getScreenWidth(85)),
              child: DefaultButton(
                text: "Sign Up",
                pressed: () async {
                  try {
                    // Create user account
                    await AuthRepository.instance
                        .createUserWithEmailAndPassword(
                      _emailField.text.trim(),
                      _passwordField.text.trim(),
                    );

                    // Authenticate user and get user object
                    User? user = FirebaseAuth.instance.currentUser;
                    if (user == null) {
                      // handle error, user not found
                      return;
                    }

                    final String userType =
                        _isOperator ? 'operator' : 'passenger';

                    // Create fields in Firestore database if they don't exist
                    final user2 = UserModel(
                        fullName: _nameField.text.trim(),
                        phoneNumber: '254${_phoneNumberField.text.trim()}',
                        isOperator: userType);
                    AuthRepository.instance.createUser(user2);
                  } catch (error) {
                    print(error);
                  }
                },
              )),
        ]));
  }

  TextFormField emailFormField() {
    return TextFormField(
      controller: _emailField,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      // validator: (value) {
      //   if (value!.isEmpty) {
      //     return "Please enter an email";
      //   }
      //   if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      //       .hasMatch(value)) {
      //     return "Please Enter a valid Email";
      //   }
      //   return null;
      // },
      // onSaved: (newValue) => email = newValue!,
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
      ),
    );
  }

  TextFormField nameFormField() {
    bool _phoneNumberError = false;
    return TextFormField(
        controller: _nameField,
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.next,
        // validator: (value) {
        //   if (value!.isEmpty) {
        //     // return "Please enter a name";
        //   }
        //   return null;
        // },
        // onSaved: (newValue) => name = newValue!,
        decoration: InputDecoration(
          // focusedErrorBorder: OutlineInputBorder(
          //     borderRadius: BorderRadius.circular(15),
          //     borderSide: const BorderSide(color: Colors.red)),
          labelStyle: TextStyle(
              fontSize: getScreenWidth(18),
              color: appPrimaryColor,
              fontWeight: FontWeight.bold),
          hintStyle: TextStyle(fontSize: getScreenWidth(13)),
          labelText: "Name",
          hintText: "Enter Your Name",
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: _phoneNumberError ? Colors.red : appPrimaryColor,
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: appPrimaryColor)),

          floatingLabelBehavior: FloatingLabelBehavior.always,
        ));
  }

  TextFormField phoneNumberFormField() {
    return TextFormField(
        controller: _phoneNumberField,
        style: TextStyle(fontSize: getScreenWidth(15)),
        decoration: InputDecoration(
          prefixText: '254',
          contentPadding: const EdgeInsets.only(top: 9, bottom: 9, left: 20),
          labelText: "Phone Number",
          hintText: 'Enter Your Phone Number',
          hintStyle: TextStyle(fontSize: getScreenWidth(13)),
          labelStyle: TextStyle(
              fontSize: getScreenWidth(18),
              color: appPrimaryColor,
              fontWeight: FontWeight.bold),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: appPrimaryColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: appPrimaryColor)),
        ),
        keyboardType: TextInputType.phone,
        textInputAction: TextInputAction.next,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(9),
        ]);
  }

  TextFormField passwordFormField() {
    return TextFormField(
        controller: _passwordField,
        keyboardType: TextInputType.visiblePassword,
        obscureText: true,
        textInputAction: TextInputAction.next,
        onSaved: (newValue) => password = newValue!,
        decoration: InputDecoration(
          labelStyle: TextStyle(
              fontSize: getScreenWidth(18),
              color: appPrimaryColor,
              fontWeight: FontWeight.bold),
          hintStyle: TextStyle(fontSize: getScreenWidth(13)),
          labelText: "Password",
          hintText: "Enter Your Preferred Password",
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
