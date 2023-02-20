import 'package:flutter/material.dart';

import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';

import '../../../common_widgets/defaultButton.dart';
import '../../../constants/constants.dart';
import '../../../constants/theme.dart';
import '../../../size_config/size_config.dart';

class CheckboxRow extends StatefulWidget {
  final bool pDetails;
  const CheckboxRow({Key? key, required this.pDetails}) : super(key: key);

  @override
  _CheckboxRowState createState() => _CheckboxRowState();
}

class _CheckboxRowState extends State<CheckboxRow> {
  bool _sendMoney = true;
  bool _tillNumber = false;
  bool _paybill = false;
  bool hasError = false;

  // final _paybillTextController = TextEditingController();
  // final _accountNumberTextController = TextEditingController();
  final _phoneNumberTextController = TextEditingController();
  // final _tillNumberTextController = TextEditingController();

  final formKey3 = GlobalKey<FormState>();
  // String mpesaNumber = '';
  String _phoneNumber = '254790193402';
  String _paybillNumber = '';
  String _accountNumber = '';
  String _tillNumberInput = '';
  double amount = 0.0;

  Future<dynamic> startTransaction(
      {required double amount,
      required String phoneNumber,
      required bool isPaybill,
      required String paybillNumber,
      required String accountNumber}) async {
    try {
      String partyB, businessShortCode;
      TransactionType transactionType;

      if (isPaybill) {
        partyB = paybillNumber;
        businessShortCode = paybillNumber;
        transactionType = TransactionType.CustomerPayBillOnline;
      } else {
        partyB = businessShortCode = paybillNumber;
        transactionType = TransactionType.CustomerBuyGoodsOnline;
      }

      final result = await MpesaFlutterPlugin.initializeMpesaSTKPush(
        businessShortCode: businessShortCode,
        transactionType: transactionType,
        partyA: phoneNumber,
        partyB: partyB,
        callBackURL:
            Uri(scheme: "https", host: "1234.1234.co.ke", path: "/1234.php"),
        accountReference: accountNumber,
        phoneNumber: phoneNumber,
        baseUri: Uri(scheme: "https", host: "sandbox.safaricom.co.ke"),
        transactionDesc: 'Mpesa demo',
        passKey:
            'bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919',
        amount: amount,
      );
    } catch (e) {
      print('Error: $e');
      // show an error message
    }
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
                        decoration: InputDecoration(
                          prefixText: '254',
                          contentPadding: const EdgeInsets.only(
                              top: 9, bottom: 9, left: 20),
                          labelText: "Enter Phone Number",
                          labelStyle: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: appPrimaryColor)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: appPrimaryColor)),
                        ),
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
                              ? Text("Phone Number cannot be empty",
                                  style: TextStyle(
                                      fontSize: getScreenWidth(13.5),
                                      color: Color.fromARGB(255, 255, 38, 23)))
                              : const Text("Enter a valid phone number",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 255, 38, 23))),
                        ),
                      )
                    ],
                  )
                : Container(),
            _paybill
                ? Column(
                    children: <Widget>[
                      TextFormField(
                        enabled: !widget.pDetails == false ? true : false,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                              top: 9, bottom: 9, left: 20),
                          labelText: "Enter Paybill Number",
                          labelStyle: TextStyle(
                              fontSize: getScreenWidth(14),
                              fontWeight: FontWeight.w600),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: appPrimaryColor)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: appPrimaryColor)),
                        ),
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
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                              top: 9, bottom: 9, left: 20),
                          labelText: "Enter Account Number",
                          labelStyle: TextStyle(
                              fontSize: getScreenWidth(14),
                              fontWeight: FontWeight.w600),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: appPrimaryColor)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: appPrimaryColor)),
                        ),
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
                                Text("Account Number cannot be empty",
                                    style: TextStyle(
                                        fontSize: getScreenWidth(13.5),
                                        color: Colors.red))
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
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                              top: 9, bottom: 9, left: 20),
                          labelText: "Enter Till Number",
                          labelStyle: TextStyle(
                              fontSize: getScreenWidth(14),
                              fontWeight: FontWeight.w600),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: appPrimaryColor)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: appPrimaryColor)),
                        ),
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
                              style: TextStyle(
                                  fontSize: getScreenWidth(13.5),
                                  color: Color.fromARGB(255, 255, 38, 23))),
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
              child: Text("Amount to pay cannot be empty",
                  style: TextStyle(
                      fontSize: getScreenWidth(13.5),
                      color: Color.fromARGB(255, 255, 38, 23))),
            ),
            SizedBox(height: getScreenHeight(15)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: getScreenWidth(90)),
              child: DefaultButton(
                  text: "Make Payment",
                  pressed: () {
                    // if (hasError = true) {
                    //   return;
                    // } else {
                    //   //TODO Add navigation to payment successful
                    // }
                    startTransaction(
                      amount: amount,
                      phoneNumber: _phoneNumber,
                      isPaybill: _paybill,
                      paybillNumber: _paybillNumber,
                      accountNumber: _accountNumber,
                    );
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => PaymentSuccessful()));
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
