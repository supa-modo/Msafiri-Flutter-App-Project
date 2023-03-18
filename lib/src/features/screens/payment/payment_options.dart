import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';

import '../../../common_widgets/defaultButton.dart';
import '../../../constants/theme.dart';
import '../../../size_config/size_config.dart';
import '../successfulpayment.dart/paymentsuccess.dart';
import 'components/textfields.dart';

class CheckboxRow extends StatefulWidget {
  final bool pDetails;
  final String mpesaNumber;
  final String jsonData;
  const CheckboxRow(
      {Key? key,
      required this.pDetails,
      required this.mpesaNumber,
      required this.jsonData})
      : super(key: key);

  @override
  _CheckboxRowState createState() => _CheckboxRowState();
}

class _CheckboxRowState extends State<CheckboxRow> {
  bool _sendMoney = false;
  bool _tillNumber = false;
  bool _paybill = false;
  bool hasError = false;
  bool _initialized = false;
  bool _error = false;
  String _jsonData = '';
  late String _mpesaNumber;

  String _transactionDate = '';
  String _phonePaidFrom = '';
  String _amount = '';
  String _mpesaReceiptNumber = '';

  // final _paybillTextController = TextEditingController();
  // final _accountNumberTextController = TextEditingController();
  final _phoneNumberTextController = TextEditingController();
  // final _tillNumberTextController = TextEditingController();

  final formKey3 = GlobalKey<FormState>();
  String _phoneNumber = '';
  String _paybillNumber = '';
  String _accountNumber = '';
  String _tillNumberInput = '';
  double amount = 0.0;

  String uid = FirebaseAuth.instance.currentUser!.uid;

  Future<String> fetchFullName(String userId) async {
    // Get the current user's document
    DocumentSnapshot<Map<String, dynamic>> userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    // Get the fullName field value from the document
    String fullName = userDoc.data()!['fullName'];

    return fullName;
  }

  Future<void> updateAccount(String transCheckoutRequestID) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    // Fetch the user's fullName from Firestore
    final userData =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    final fullName = userData['fullName'];

    // Update the initData map with the fullName
    final initData = {
      'CheckoutRequestID': transCheckoutRequestID,
      'Name': fullName,
    };

    try {
      await FirebaseFirestore.instance
          .collection('mobileTransactions')
          .doc(transCheckoutRequestID)
          .set(initData);
      print("Transaction initialized.");
    } catch (error) {
      print("Failed to initialize transaction: $error");
    }
  }

  Future<dynamic> startPaybillTransaction({
    required String userPhone,
    required double amount,
    required String paybill,
    required String accountNumber,
  }) async {
    try {
      final transactionInitialisation =
          await MpesaFlutterPlugin.initializeMpesaSTKPush(
        businessShortCode: "174379",
        transactionType: TransactionType.CustomerPayBillOnline,
        amount: amount,
        partyA: userPhone,
        partyB: paybill,
        callBackURL: Uri.parse(
          "https://us-central1-pts-project-x2.cloudfunctions.net/mpesaCallback",
        ),
        accountReference: accountNumber,
        phoneNumber: userPhone,
        baseUri: Uri.parse("https://sandbox.safaricom.co.ke"),
        transactionDesc: "Fare payment",
        passKey:
            'bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919',
      );

      final result = transactionInitialisation as Map<String, dynamic>;

      if (result.containsKey("ResponseCode")) {
        final transResponseCode = result["ResponseCode"] as String;
        print("Resulting Code: " + transResponseCode);
        if (transResponseCode == '0') {
          updateAccount(result["CheckoutRequestID"] as String);
        }
      }

      print("RESULT: " + transactionInitialisation.toString());
    } catch (e) {
      // Handle the exception here.
      print("Exception Caught: " + e.toString());
    }
  }

  Future<dynamic> startSendMoneyTransaction({
    required String userPhone,
    required double amount,
    required String tillNumber,
  }) async {
    try {
      final transactionInitialisation =
          await MpesaFlutterPlugin.initializeMpesaSTKPush(
        businessShortCode: tillNumber,
        transactionType: TransactionType.CustomerBuyGoodsOnline,
        amount: amount,
        partyA: userPhone,
        partyB: tillNumber,
        callBackURL: Uri.parse(
          "https://us-central1-pts-project-x2.cloudfunctions.net/mpesaCallback",
        ),
        accountReference: "Matatu Fare",
        phoneNumber: userPhone,
        baseUri: Uri.parse("https://sandbox.safaricom.co.ke"),
        transactionDesc: "Fare payment",
        passKey:
            'bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919',
      );

      final result = transactionInitialisation as Map<String, dynamic>;

      if (result.containsKey("ResponseCode")) {
        final transResponseCode = result["ResponseCode"] as String;
        print("Resulting Code: " + transResponseCode);
        if (transResponseCode == '0') {
          updateAccount(result["CheckoutRequestID"] as String);
        }
      }

      print("RESULT: " + transactionInitialisation.toString());
    } catch (e) {
      // Handle the exception here.
      print("Exception Caught: " + e.toString());
    }
  }

  Future<dynamic> startTillNumberTransaction({
    required String userPhone,
    required double amount,
    required String tillNumber,
    required String accountRef,
  }) async {
    try {
      final transactionInitialisation =
          await MpesaFlutterPlugin.initializeMpesaSTKPush(
        businessShortCode: tillNumber,
        transactionType: TransactionType.CustomerBuyGoodsOnline,
        amount: amount,
        partyA: userPhone,
        partyB: tillNumber,
        callBackURL: Uri.parse(
          "https://us-central1-pts-project-x2.cloudfunctions.net/mpesaCallback",
        ),
        accountReference: accountRef,
        phoneNumber: userPhone,
        baseUri: Uri.parse("https://sandbox.safaricom.co.ke"),
        transactionDesc: "Fare payment",
        passKey:
            'bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919',
      );

      final result = transactionInitialisation as Map<String, dynamic>;

      if (result.containsKey("ResponseCode")) {
        final transResponseCode = result["ResponseCode"] as String;
        print("Resulting Code: " + transResponseCode);
        if (transResponseCode == '0') {
          updateAccount(result["CheckoutRequestID"] as String);
        }
      }

      print("RESULT: " + transactionInitialisation.toString());
    } catch (e) {
      // Handle the exception here.
      print("Exception Caught: " + e.toString());
    }
  }

  // Define an async function to initialize Firebase
  Future<void> initializeFirebase() async {
    try {
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      print(e.toString());
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFirebase();
    super.initState();
    _jsonData = widget.jsonData;
    _mpesaNumber = widget.mpesaNumber;
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.data.isNotEmpty) {
        setState(() {
          _transactionDate = message.data['transactionDate'];
          _phonePaidFrom = message.data['phoneNumber'];
          _amount = message.data['amount'];
          _mpesaReceiptNumber = message.data['mpesaReceiptNumber'];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey3,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Checkbox(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  value: _sendMoney,
                  onChanged: !widget.pDetails
                      ? null
                      : (value) {
                          setState(() {
                            _sendMoney = value!;
                            _tillNumber = false;
                            _paybill = false;
                          });
                        },
                ),
                Text(
                  "Send Money",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: getScreenWidth(14)),
                ),
                Checkbox(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  value: _tillNumber,
                  onChanged: !widget.pDetails
                      ? null
                      : (value) {
                          setState(() {
                            _tillNumber = value!;
                            _sendMoney = false;
                            _paybill = false;
                          });
                        },
                ),
                Text(
                  "Till number",
                  style: TextStyle(
                      fontSize: getScreenWidth(14),
                      fontWeight: FontWeight.bold),
                ),
                Checkbox(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  value: _paybill,
                  onChanged: !widget.pDetails
                      ? null
                      : (value) {
                          setState(() {
                            _sendMoney = false;
                            _tillNumber = false;
                            _paybill = value!;
                          });
                        },
                ),
                Text(
                  "Paybill",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: getScreenWidth(14)),
                ),
              ],
            ),
            _sendMoney
                ? Column(
                    children: <Widget>[
                      TextFormField(
                        enabled: !widget.pDetails == false ? true : false,
                        controller: _phoneNumberTextController,
                        decoration: phoneTextField(),
                        keyboardType: TextInputType.number,
                        maxLength: 9,
                        onChanged: (value) {
                          setState(() {
                            _phoneNumber = '254$value';
                            if (_phoneNumber.isEmpty ||
                                _phoneNumber.length < 10) {
                              hasError = true;
                            } else {
                              hasError = false;
                            }
                          });
                        },
                      ),
                      Offstage(
                        offstage: !widget.pDetails,
                        child: Visibility(
                          visible:
                              _phoneNumber.isEmpty || _phoneNumber.length < 10,
                          child: _phoneNumber.isEmpty
                              ? Text(
                                  "Phone Number cannot be empty",
                                  style: visibilityText(),
                                )
                              : Text(
                                  "Enter a valid phone number",
                                  style: visibilityText(),
                                ),
                        ),
                      )
                    ],
                  )
                : Container(),
            _paybill
                ? Column(
                    children: <Widget>[
                      TextFormField(
                        // controller: _paybillTextController,
                        enabled: !widget.pDetails == false ? true : false,
                        keyboardType: TextInputType.number,
                        decoration: paybillTextField(),
                        onChanged: (value) {
                          setState(() {
                            _paybillNumber = value;
                            if (_paybillNumber.isEmpty ||
                                _accountNumber.isEmpty) {
                              hasError = true;
                            } else {
                              hasError = false;
                            }
                          });
                        },
                      ),
                      SizedBox(height: getScreenHeight(10)),
                      TextFormField(
                        enabled: !widget.pDetails == false ? true : false,
                        decoration: accNoTextField(),
                        onChanged: (value) {
                          setState(() {
                            _accountNumber = value;
                            if (_paybillNumber.isEmpty ||
                                _accountNumber.isEmpty) {
                              hasError = true;
                            } else {
                              hasError = false;
                            }
                          });
                        },
                      ),
                      Offstage(
                        offstage: !widget.pDetails,
                        child: Visibility(
                          visible:
                              _paybillNumber.isEmpty || _accountNumber.isEmpty,
                          child: Column(
                            children: [
                              if (_paybillNumber.isEmpty)
                                Text("Paybill Number cannot be empty",
                                    style: TextStyle(
                                        fontSize: getScreenWidth(13.5),
                                        color: Colors.red)),
                              if (_accountNumber.isEmpty)
                                Text(
                                  "Account Number cannot be empty",
                                  style: visibilityText(),
                                )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : Container(),
            _tillNumber
                ? Column(
                    children: [
                      TextFormField(
                        enabled: !widget.pDetails == false ? true : false,
                        decoration: tillNoTextField(),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            _tillNumberInput = value;
                            if (_tillNumberInput.isEmpty) {
                              hasError = true;
                            } else {
                              hasError = false;
                            }
                          });
                        },
                      ),
                      Offstage(
                        offstage: !widget.pDetails,
                        child: Visibility(
                          visible: _tillNumberInput.isEmpty,
                          child: Text("Till Number value cannot be empty",
                              style: visibilityText()),
                        ),
                      ),
                    ],
                  )
                : Container(),
            SizedBox(height: getScreenHeight(10)),
            TextFormField(
              decoration: inputDeco("Enter amount to pay"),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  amount = double.parse(value);
                });
              },
            ),
            Visibility(
              visible: amount < 1,
              child: Text(
                "Amount to pay cannot be empty",
                style: visibilityText(),
              ),
            ),
            SizedBox(height: getScreenHeight(15)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: getScreenWidth(90)),
              child: DefaultButton(
                  text: "Make Payment",
                  pressed: () {
                    //   //TODO Add navigation to payment successful

                    // void _pay(BuildContext context) {
                    final form = formKey3.currentState;
                    if (form != null && form.validate()) {
                      form.save();

                      if (_tillNumberInput == '' &&
                          _paybillNumber == '' &&
                          _accountNumber == '') {
                        final Map<String, dynamic> jsonMap =
                            json.decode(_jsonData);

                        final String transType = jsonMap['transactionType'];
                        final String paymentNo = jsonMap['paymentNumber'];
                        final String accountNo = jsonMap['accountReference'];
                        if (transType == 'paybill') {
                          startPaybillTransaction(
                              accountNumber: accountNo,
                              amount: amount,
                              paybill: paymentNo,
                              userPhone: _mpesaNumber);
                        } else if (transType == 'tillNumber') {
                          startTillNumberTransaction(
                              amount: amount,
                              tillNumber: paymentNo,
                              userPhone: _mpesaNumber,
                              accountRef: accountNo);
                        } else if (transType == 'sendMoney') {
                          startSendMoneyTransaction(
                              amount: amount,
                              // phoneNumber: _phoneNumber,
                              userPhone: _mpesaNumber,
                              tillNumber: '');
                        }
                      } else {
                        if (_paybill == true) {
                          startPaybillTransaction(
                              accountNumber: _accountNumber,
                              amount: amount,
                              paybill: _paybillNumber,
                              userPhone: _mpesaNumber);
                        } else if (_tillNumber == true) {
                          startTillNumberTransaction(
                              amount: amount,
                              tillNumber: _tillNumberInput,
                              userPhone: _mpesaNumber,
                              accountRef: 'Matatu Fare');
                        } else if (_sendMoney == true) {
                          startSendMoneyTransaction(
                              amount: amount,
                              // phoneNumber: _phoneNumber,
                              userPhone: _mpesaNumber,
                              tillNumber: '');
                        }
                      }

                      if (_transactionDate != '' &&
                          _phonePaidFrom != '' &&
                          _amount != '' &&
                          _mpesaReceiptNumber != '') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PaymentSuccessful(
                                      transactionDate: _transactionDate,
                                      phonePaidFrom: _phonePaidFrom,
                                      amount: _amount,
                                      mpesaReceiptNumber: _mpesaReceiptNumber,
                                    )));
                      } else {
                        print('No message passed');
                      }
                    }
                    // }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
