import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_x/src/features/screens/home_screen/home_screen.dart';

import '../../../constants/constants.dart';
import '../../../size_config/size_config.dart';
import 'otp_form.dart';
import 'sign_up_exceptions.dart';

class OtpVerification2 extends StatefulWidget {
  final String verificationId;
  final String phoneNumber;

  const OtpVerification2({
    Key? key,
    required this.phoneNumber,
    required this.verificationId,
  }) : super(key: key);

  @override
  State<OtpVerification2> createState() => _OtpVerification2State();
}

class _OtpVerification2State extends State<OtpVerification2> {
  final _codeController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  bool _isLoading = false;
  late String _verificationId;
  bool _timerInProgress = false;
  int _timer = 90;

  @override
  void initState() {
    super.initState();
    _verificationId = widget.verificationId;
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  // Starts the timer and updates the UI every second
  void _startTimer() {
    _timerInProgress = true;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timer == 0) {
        _timerInProgress = false;
        timer.cancel();
        _timer = 90;
      } else {
        _timer--;
      }
      setState(() {});
    });
  }

  void _verifyCode() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: widget.phoneNumber,
        verificationCompleted: (phoneAuthCredential) async {
          await _auth.signInWithCredential(phoneAuthCredential);
        },
        verificationFailed: (verificationFailed) async {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(verificationFailed.message ?? "Unknown error"),
              backgroundColor: Colors.red,
            ),
          );
          setState(() {
            _isLoading = false;
          });
        },
        codeSent: (verificationId, resendToken) async {
          setState(() {
            _verificationId = verificationId;
            _isLoading = false;
          });
          _startTimer();
        },
        codeAutoRetrievalTimeout: (verificationId) async {},
      );
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(SignUpExceptions.generateErrorMessage(e.toString())),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _resendCode() async {
    _startTimer();
    _verifyCode();
  }

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
                Text(
                  "A verification code will be sent to ${widget.phoneNumber} \n Enter the code sent below to complete the verification",
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

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Didn't receive a code?",
                      style: TextStyle(
                        fontSize: getScreenWidth(16),
                      ),
                    ),
                    TextButton(
                      onPressed: !_timerInProgress ? _resendCode : null,
                      child: Text(
                        _timerInProgress
                            ? "Resend in $_timer seconds"
                            : "Resend now",
                        style: TextStyle(
                          fontSize: getScreenWidth(16),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: getScreenHeight(40)),

                SizedBox(
                  width: getScreenWidth(170),
                  height: getScreenHeight(50),
                  child: TextButton(
                    onPressed: _verifyCode,
                    // () {
                    //   Get.to(() => HomeScreen());
                    // },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 30, 117, 247)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25))),
                    ),
                    child: _isLoading
                        ? Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: getScreenHeight(5), horizontal: 63),
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            "Verify",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: getScreenWidth(16),
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
