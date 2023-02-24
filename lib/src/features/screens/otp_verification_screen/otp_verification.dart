// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/services.dart';
// import 'package:project_x/src/features/screens/home_screen/home_screen.dart';

// import '../../../constants/constants.dart';
// import '../../../size_config/size_config.dart';
// import 'sign_up_exceptions.dart';

// class OtpVerification extends StatefulWidget {
//   final String verificationId;
//   final String phoneNumber;

//   const OtpVerification({
//     Key? key,
//     required this.verificationId,
//     required this.phoneNumber,
//   }) : super(key: key);

//   @override
//   _OtpVerificationState createState() => _OtpVerificationState();
// }

// class _OtpVerificationState extends State<OtpVerification> {
//   final _codeController = TextEditingController();
//   final _auth = FirebaseAuth.instance;
//   bool _isLoading = false;
//   late String _verificationId;

//   @override
//   void initState() {
//     super.initState();
//     _verificationId = widget.verificationId;
//   }

//   @override
//   void dispose() {
//     _codeController.dispose();
//     super.dispose();
//   }

//   void _verifyCode() async {
//     setState(() {
//       _isLoading = true;
//     });

//     try {
//       final credential = PhoneAuthProvider.credential(
//         verificationId: _verificationId,
//         smsCode: _codeController.text.trim(),
//       );

//       await _auth.signInWithCredential(credential);

//       setState(() {
//         _isLoading = false;
//       });

//       await Services.instance.setPhoneNumber(widget.phoneNumber);

//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (_) => HomeScreen()),
//       );
//     } on FirebaseAuthException catch (e) {
//       setState(() {
//         _isLoading = false;
//       });

//       if (e.code == 'invalid-verification-code') {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Invalid verification code'),
//             backgroundColor: Colors.red,
//           ),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(SignUpExceptions.generateErrorMessage(e.code)),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }
//     } catch (e) {
//       setState(() {
//         _isLoading = false;
//       });

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(SignUpExceptions.generateErrorMessage(e.toString())),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: const IconThemeData(color: Colors.black),
//         titleTextStyle: TextStyle(
//           fontSize: getScreenWidth(22),
//           fontWeight: FontWeight.bold,
//           color: appPrimaryColor,
//         ),
//         title: const Text("Phone Verification"),
//         centerTitle: true,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios, color: appPrimaryColor),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//       ),
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: getScreenWidth(20)),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               SizedBox(height: getScreenWidth(30)),
//               Text(
//                 "Verification Code",
//                 style: headingStyle,
//               ),
//               SizedBox(height: getScreenHeight(10)),
//               Text(
//                 "Enter the verification code sent to \n${widget.phoneNumber}",
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(height: getScreenHeight(10)),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   _buildCodeInputField(),
//                   SizedBox(width: getScreenWidth(10)),
//                   _buildCodeInputField(),
//                   SizedBox(width: getScreenWidth(10)),
//                   _buildCodeInputField(),
//                   SizedBox(width: getScreenWidth(10)),
//                   _buildCodeInputField(),
//                 ],
//               ),
//               SizedBox(height: getScreenHeight(30)),
//               _isLoading
//                   ? CircularProgressIndicator()
//                   : ElevatedButton(
//                       style: ButtonStyle(
//                         backgroundColor: MaterialStateProperty.all<Color>(
//                             const Color.fromARGB(255, 30, 117, 247)),
//                         shape:
//                             MaterialStateProperty.all<RoundedRectangleBorder>(
//                                 RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(20))),
//                       ),
//                       onPressed: _verifyCode,
//                       child: Text(
//                         "VERIFY",
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontSize: getScreenWidth(16),
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildCodeInputField() {
//     return SizedBox(
//       width: getScreenWidth(50),
//       height: getScreenHeight(55),
//       child: TextFormField(
//         controller: _codeController,
//         onChanged: (value) {
//           if (value.length == 1) {
//             FocusScope.of(context).nextFocus();
//           }
//         },
//         style: Theme.of(context).textTheme.headline6,
//         keyboardType: TextInputType.number,
//         decoration: InputDecoration(
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),
//         textAlign: TextAlign.center,
//         inputFormatters: [
//           LengthLimitingTextInputFormatter(1),
//           FilteringTextInputFormatter.digitsOnly
//         ],
//       ),
//     );
//   }
// }
