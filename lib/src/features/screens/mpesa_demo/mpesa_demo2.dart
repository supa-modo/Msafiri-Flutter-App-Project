import 'package:flutter/material.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';
import 'package:project_x/src/common_widgets/defaultButton.dart';
import 'package:project_x/src/features/screens/mpesa_demo/demoMpesa3.dart';

import '../../../constants/constants.dart';
import '../../../size_config/size_config.dart';
import 'qrdemo.dart';

class MpesaTransaction extends StatefulWidget {
  const MpesaTransaction({super.key});

  @override
  State<MpesaTransaction> createState() => _MpesaTransactionState();
}

class _MpesaTransactionState extends State<MpesaTransaction> {
  String _mpesaNumber = '';
  double _amount = 1;
  String partyB = '174379';

  final _formKey = GlobalKey<FormState>();
  Future<void> startCheckout(
      {required String userPhone, required double amount}) async {
    dynamic transactionInitialisation;

    try {
      transactionInitialisation =
          await MpesaFlutterPlugin.initializeMpesaSTKPush(
              businessShortCode: partyB,
              // transactionType: TransactionType.CustomerBuyGoodsOnline,
              transactionType: TransactionType.CustomerPayBillOnline,
              amount: amount,
              partyA: userPhone,
              partyB: partyB,
              callBackURL: Uri.parse(
                  'https://us-central1-pts-project-x2.cloudfunctions.net/mpesaCallback'),
              accountReference: "shoe",
              phoneNumber: userPhone,
              baseUri: Uri(scheme: "https", host: "sandbox.safaricom.co.ke"),
              transactionDesc: "purchase",
              passKey:
                  'bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919');

      print("TRANSACTION RESULT: " + transactionInitialisation.toString());

      return transactionInitialisation;
    } catch (e) {
      print("CAUGHT EXCEPTION: " + e.toString());
    }
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios,
              color: Color.fromARGB(255, 95, 94, 94)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        title: const Text(
          "Admin Demos",
          style: TextStyle(color: Color.fromARGB(255, 95, 94, 94)),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Text(
              "Mpesa Demo Trials",
              style: headingStyle,
            ),
            Container(
              height: getScreenHeight(30),
              width: getScreenWidth(300),
              color: Colors.orange,
            ),
            SizedBox(height: 15),
            TextFormField(
              // controller: _phoneNumberField,
              decoration: InputDecoration(
                prefixText: '254',
                contentPadding:
                    const EdgeInsets.only(top: 9, bottom: 9, left: 20),
                labelText: "Enter Your Mpesa Number",
                labelStyle:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
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
                  _mpesaNumber = '254$value';
                });
              },
            ),
            TextFormField(
              // controller: _amountField,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.only(top: 9, bottom: 9, left: 20),
                labelText: "Enter Amount",
                labelStyle:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
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
                  _amount = double.parse(value);
                });
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: getScreenHeight(10),
                  horizontal: getScreenWidth(20)),
              child: DefaultButton(
                  text: "Make Payment",
                  pressed: () async {
                    startCheckout(userPhone: _mpesaNumber, amount: _amount);
                  }),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: getScreenHeight(10),
                  horizontal: getScreenWidth(20)),
              child: DefaultButton(
                  text: "Qr Scan Demo",
                  pressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QRCodeScannerScreen3(),
                        // builder: (context) => QRCodeScannerScreen1(),
                      ),
                    );
                  }),
            ),
            Padding(
                padding: EdgeInsets.symmetric(
                    vertical: getScreenHeight(10),
                    horizontal: getScreenWidth(20)),
                child: DefaultButton(
                    text: "Keronei's demo",
                    pressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyHomePage1(),
                        ),
                      );
                    })),
          ],
        ),
      ),
    );
  }
}
