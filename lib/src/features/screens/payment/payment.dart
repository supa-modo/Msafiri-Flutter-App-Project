import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';
import 'package:project_x/src/features/screens/home_screen/components/payment.dart';
import 'package:project_x/src/features/screens/successfulpayment.dart/paymtSuccess.dart';
import 'package:provider/provider.dart';

import '../../../common_widgets/defaultButton.dart';
import '../../../constants/constants.dart';
import '../../../constants/theme.dart';
import '../../../size_config/size_config.dart';
import '../new_trip/location.dart';
import 'components/qrScanScreen.dart';
import 'components/textfields.dart';

class QRScanScreen extends StatefulWidget {
  final String mpesaNumber;
  const QRScanScreen({super.key, required this.mpesaNumber});

  @override
  State<QRScanScreen> createState() => _QRScanScreenState1();
}

final _paymentDetailsController = TextEditingController();

class _QRScanScreenState1 extends State<QRScanScreen> {
  bool pDetails = false;
  bool qrScan = false;
  String? _scannedText;
  late String _mpesaNumber;
  bool _sendMoney = false;
  bool _tillNumber = false;
  bool _paybill = false;
  bool hasError = false;
  bool _initialized = false;
  bool _error = false;

  String checkOutReqID = '';
  String _transactionDate = '';
  String _phonePaidFrom = '';
  String _amount = '';
  String _mpesaReceiptNumber = '';

  final _phoneNumberTextController = TextEditingController();

  final formKey3 = GlobalKey<FormState>();
  String _phoneNumber = '';
  String _paybillNumber = '';
  String _accountNumber = '';
  String _tillNumberInput = '';
  double amountToPay = 0.0;

  String transactionType = '';
  String paymentNumber = '';
  String accountReference = '';

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

    final locationProvider =
        Provider.of<LocationProvider>(context, listen: false);
    final destination = LocationProvider().destination;
    final destinationName = destination?.toString() ?? 'Not set';

    // Update the initData map with the fullName
    final initData = {
      'CheckoutRequestID': transCheckoutRequestID,
      'Name': fullName,
      'Destination': destinationName,
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

  Future<dynamic> startPaybillCheckout({
    required String userPhone,
    required double amount,
    required String paybill,
    required String accountNumber,
  }) async {
    dynamic transactionInitialisation;

    try {
      transactionInitialisation =
          await MpesaFlutterPlugin.initializeMpesaSTKPush(
              businessShortCode: paybill,
              // transactionType: TransactionType.CustomerBuyGoodsOnline,
              transactionType: TransactionType.CustomerPayBillOnline,
              amount: amount,
              partyA: userPhone,
              partyB: paybill,
              callBackURL: Uri.parse(
                  "https://us-central1-pts-project-x2.cloudfunctions.net/mpesaCallback"),
              accountReference: accountNumber,
              phoneNumber: userPhone,
              baseUri: Uri(scheme: "https", host: "sandbox.safaricom.co.ke"),
              transactionDesc: "Fare payment",
              passKey:
                  'bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919');

      final result = transactionInitialisation as Map<String, dynamic>;

      if (result.containsKey("ResponseCode")) {
        final transResponseCode = result["ResponseCode"] as String;
        print("Resulting Code: " + transResponseCode);
        if (transResponseCode == '0') {
          updateAccount(result["CheckoutRequestID"] as String);
          setState(() {
            checkOutReqID = result["CheckoutRequestID"] as String;
          });
          // getData();
          Navigator.push(
            context,
            MaterialPageRoute(
              // builder: (context) => PaymentSuccessful(checkOutRequestID: checkOutReqID),
              builder: (context) =>
                  PaymentSuccessful(checkOutRequestID: checkOutReqID, partyB: paybill),
            ),
          );
        }
      }

      print("RESULT: " + transactionInitialisation.toString());
    } catch (e) {
      print("CAUGHT EXCEPTION: " + e.toString());
    }
  }

  Future<dynamic> startTillCheckout({
    required String userPhone,
    required double amount,
    required String tillNumber,
    required String accountNumber,
  }) async {
    dynamic transactionInitialisation;

    try {
      transactionInitialisation = await MpesaFlutterPlugin.initializeMpesaSTKPush(
          businessShortCode: tillNumber,
          transactionType: TransactionType.CustomerBuyGoodsOnline,
          amount: amount,
          partyA: userPhone,
          partyB: tillNumber,
          callBackURL: Uri.parse(
              "https://us-central1-pts-project-x2.cloudfunctions.net/mpesaCallback"),
          accountReference: accountNumber,
          phoneNumber: userPhone,
          baseUri: Uri(scheme: "https", host: "sandbox.safaricom.co.ke"),
          transactionDesc: "Fare payment",
          passKey:
              'bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919');

      final result = transactionInitialisation as Map<String, dynamic>;

      if (result.containsKey("ResponseCode")) {
        final transResponseCode = result["ResponseCode"] as String;
        print("Resulting Code: " + transResponseCode);
        if (transResponseCode == '0') {
          updateAccount(result["CheckoutRequestID"] as String);
          setState(() {
            checkOutReqID = result["CheckoutRequestID"] as String;
          });
          Navigator.push(
            context,
            MaterialPageRoute(
              // builder: (context) => PaymentSuccessful(checkOutRequestID: checkOutReqID),
              builder: (context) =>
                  PaymentSuccessful(checkOutRequestID: checkOutReqID, partyB: tillNumber),
            ),
          );
        }
      }

      print("RESULT: " + transactionInitialisation.toString());
    } catch (e) {
      print("CAUGHT EXCEPTION: " + e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    _mpesaNumber = widget.mpesaNumber;
  }

  void _onScanQRCodePressed() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QRCodeScannerScreen(),
      ),
    );

    setState(() {
      _scannedText = result;
      String qrText = result;
      qrScan = true;

      // Separate the strings based on transaction type, payment number, and account reference
      if (qrText.startsWith('PB')) {
        transactionType = 'paybill';
      } else if (qrText.startsWith('BG')) {
        transactionType = 'tillNumber';
      } else if (qrText.startsWith('SM')) {
        transactionType = 'sendMoney';
      }

      List<String> qrParts = qrText.split(' ');
      if (qrParts.length >= 2) {
        paymentNumber = qrParts[1];
      }
      if (qrParts.length >= 3) {
        accountReference = qrParts[2];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
          fontSize: getScreenWidth(21),
          fontWeight: FontWeight.bold,
          color: appPrimaryColor,
        ),
        title: const Text("Make a Payment"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: appPrimaryColor),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                left: getScreenWidth(8),
                right: getScreenWidth(8),
                bottom: getScreenHeight(5),
                top: getScreenHeight(5)),
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      height: getScreenHeight(220),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: const Color.fromARGB(255, 190, 190, 190)),
                      child: SizedBox(
                        height: getScreenHeight(215),
                        width: double.infinity,
                        child: Padding(
                          padding: EdgeInsets.only(top: getScreenHeight(50)),
                          child: Column(
                            children: [
                              TextButton(
                                onPressed: _onScanQRCodePressed,
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.photo_camera,
                                      size: getScreenWidth(60),
                                      color: appPrimaryColor,
                                    ),
                                    SizedBox(height: getScreenHeight(15)),
                                    Text(
                                      "Scan QR Code \n to capture pament details",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: getScreenWidth(14),
                                          fontWeight: FontWeight.bold,
                                          color: const Color.fromARGB(
                                              255, 44, 43, 43)),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: getScreenHeight(10)),
                    Text(
                      "Payment Details Captured",
                      style: TextStyle(
                          color: appPrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: getScreenWidth(14)),
                    ),
                    SizedBox(height: getScreenHeight(10)),
                    Container(
                      height: getScreenHeight(55),
                      width: getScreenWidth(400),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(108, 104, 104, 104),
                          borderRadius: BorderRadius.circular(15)),
                      child: Stack(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: getScreenWidth(20),
                              vertical: getScreenHeight(17),
                            ),
                            child: Text(
                              _scannedText ??
                                  'Scanned Payment Details will appear here',
                              style: TextStyle(
                                  fontSize: getScreenWidth(15),
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 52, 136, 54)),
                            ),
                          ),
                          Positioned(
                            top: getScreenHeight(17),
                            right: getScreenWidth(20),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _scannedText = null;
                                  qrScan = false;
                                });
                              },
                              child: Icon(
                                Icons.clear,
                                color: Color.fromARGB(255, 52, 136, 54),
                                size: getScreenWidth(24),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: getScreenHeight(5)),
                    Text(
                      'Or',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: getScreenWidth(14.5),
                          color: appPrimaryColor),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Enter Payment Details Manually?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: getScreenWidth(14.5),
                              color: appPrimaryColor),
                        ),
                        Checkbox(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          value: pDetails,
                          onChanged: (_scannedText == null)
                              ? (value) {
                                  setState(() {
                                    pDetails = value!;
                                  });
                                }
                              : null,
                        )
                      ],
                    ),
                    SizedBox(height: getScreenHeight(5)),
                    Form(
                      key: formKey3,
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Checkbox(
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                ),
                                value: _sendMoney,
                                onChanged: !pDetails
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                ),
                                value: _tillNumber,
                                onChanged: !pDetails
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                ),
                                value: _paybill,
                                onChanged: !pDetails
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
                                      enabled:
                                          !pDetails == false ? true : false,
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
                                      offstage: !pDetails,
                                      child: Visibility(
                                        visible: _phoneNumber.isEmpty ||
                                            _phoneNumber.length < 10,
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
                                      enabled:
                                          !pDetails == false ? true : false,
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
                                      enabled:
                                          !pDetails == false ? true : false,
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
                                      offstage: !pDetails,
                                      child: Visibility(
                                        visible: _paybillNumber.isEmpty ||
                                            _accountNumber.isEmpty,
                                        child: Column(
                                          children: [
                                            if (_paybillNumber.isEmpty)
                                              Text(
                                                  "Paybill Number cannot be empty",
                                                  style: TextStyle(
                                                      fontSize:
                                                          getScreenWidth(13.5),
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
                                      enabled:
                                          !pDetails == false ? true : false,
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
                                      offstage: !pDetails,
                                      child: Visibility(
                                        visible: _tillNumberInput.isEmpty,
                                        child: Text(
                                            "Till Number value cannot be empty",
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
                                amountToPay = double.parse(value);
                              });
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                          Visibility(
                            visible: amountToPay < 1,
                            child: Text(
                              "Amount to pay cannot be empty",
                              style: visibilityText(),
                            ),
                          ),
                          SizedBox(height: getScreenHeight(15)),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: getScreenWidth(90)),
                      child: DefaultButton(
                        text: "Make Payment",
                        pressed: () async {
                          //   //TODO Add navigation to payment successful

                          final form = formKey3.currentState;
                          if (form != null && form.validate()) {
                            form.save();
                            if (_scannedText == null) {
                              if (_paybill) {
                                startPaybillCheckout(
                                    userPhone: _mpesaNumber,
                                    amount: amountToPay,
                                    paybill: _paybillNumber,
                                    accountNumber: _accountNumber);
                              }
                              //else if (_tillNumber) {
                              //   startTillCheckout(
                              //     userPhone: _mpesaNumber,
                              //     amount: amountToPay,
                              //     tillNumber: _tillNumberInput);
                              // } else if (_sendMoney) {
                              //   startSendMoneyCheckout(
                              //     userPhone: _mpesaNumber,
                              //     amount: amountToPay,
                              //     phoneNumber: _phoneNumber);
                              // }

                            } else {
                              if (transactionType == "paybill") {
                                startPaybillCheckout(
                                    userPhone: _mpesaNumber,
                                    amount: amountToPay,
                                    paybill: paymentNumber,
                                    accountNumber: accountReference);
                              } else {
                                if (transactionType == "tillNumber") {
                                  startTillCheckout(
                                    userPhone: _mpesaNumber,
                                    amount: amountToPay,
                                    tillNumber: paymentNumber,
                                    accountNumber: accountReference,
                                  );
                                }
                                //else {
                                //     if (transactionType == "sendMoney") {
                                //       startSendMoneyCheckout(
                                //         userPhone: _mpesaNumber,
                                //         amount: amountToPay,
                                //         phoneNumber: paymentNumber,
                                //       );
                                //     }
                                // }
                              }
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
