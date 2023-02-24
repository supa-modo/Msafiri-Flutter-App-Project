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
  bool timerInProgress = false;
  int timer1 = 120;

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

  void startTimer() {
    timerInProgress = true;
    setState(() {});
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timer1 == 0) {
        timerInProgress = false;
        timer.cancel();
        timer1 = 120;
        setState(() {});
      } else {
        timer1--;
        setState(() {});
      }
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
          startTimer();
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
    startTimer();
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
                  "Enter the verification code sent to \n${widget.phoneNumber}",
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
                      Text(
                          "Resend code after: ${(timer1 ~/ 60).toString().padLeft(2, '0')}.${(timer1 % 60).toString().padLeft(2, '0')}"),
                      SizedBox(height: getScreenHeight(10)),
                      AnimatedOpacity(
                        opacity: timerInProgress ? 0.5 : 1,
                        duration: const Duration(milliseconds: 500),
                        child: TextButton(
                          onPressed: timerInProgress || _isLoading
                              ? null
                              : _resendCode,
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
                          ),
                        ),
                      ),
                    ],
                  ),
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
