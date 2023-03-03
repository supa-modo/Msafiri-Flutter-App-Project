import 'package:flutter/material.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';
import 'package:project_x/src/features/screens/home_screen/home_screen.dart';

import '../../../common_widgets/defaultButton.dart';
import '../../../constants/theme.dart';
import '../../../size_config/size_config.dart';
import 'components/textfields.dart';
import 'transaction.dart';

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
  String _phoneNumber = '254790193402';
  String _paybillNumber = '';
  String _accountNumber = 'MpesaDemo';
  String _tillNumberInput = '';
  double amount = 0.0;

  Future<dynamic> startCheckout({
    required String userPhone,
    required double amount,
    required bool isPaybill,
    required bool isTillNumber,
  }) async {
    final String partyB = isPaybill ? _paybillNumber : _tillNumberInput;
    final TransactionType transactionType = isPaybill
        ? TransactionType.CustomerPayBillOnline
        : TransactionType.CustomerBuyGoodsOnline;
    try {
      final result = await MpesaFlutterPlugin.initializeMpesaSTKPush(
        businessShortCode: isPaybill ? _paybillNumber : _tillNumberInput,
        transactionType: transactionType,
        amount: amount,
        partyA: userPhone,
        partyB: partyB,
        callBackURL:
            Uri(scheme: "https", host: "1234.1234.co.ke", path: "/1234.php"),
        accountReference: "MpesaDemo",
        phoneNumber: _phoneNumber,
        baseUri: Uri(scheme: "https", host: "sandbox.safaricom.co.ke"),
        transactionDesc: "Mpesa demo transaction",
        passKey:
            'bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919',
      );

      print("TRANSACTION RESULT: " + result.toString());

      return result;
    } catch (e) {
      print("CAUGHT EXCEPTION: " + e.toString());
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

                      startCheckout(
                        userPhone: _phoneNumber,
                        amount: amount,
                        isPaybill: _paybill,
                        isTillNumber: _tillNumber,
                      ).then((_) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(),
                          ),
                        );
                      }).catchError((error) {
                        print('Error: $error');
                      });
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
