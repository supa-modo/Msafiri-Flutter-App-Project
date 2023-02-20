import 'package:flutter/material.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';

import '../../../constants/constants.dart';
import '../../../size_config/size_config.dart';

class PaymentScreen2 extends StatefulWidget {
  const PaymentScreen2({super.key});

  @override
  _PaymentScreen2State createState() => _PaymentScreen2State();
}

class _PaymentScreen2State extends State<PaymentScreen2> {
  // final _formKey = GlobalKey<FormState>();
  late String _mpesaNumber;
  late double _amount;

  Future<dynamic> startTransaction(
      {required double amount, required String phoneNumber}) async {
    try {
      final result = await MpesaFlutterPlugin.initializeMpesaSTKPush(
        businessShortCode: '174379',
        transactionType: TransactionType
            .CustomerPayBillOnline, //or CustomerBuyGoodsOnline for till numbers
        partyA: phoneNumber,
        partyB: '174379',
        callBackURL:
            Uri(scheme: "https", host: "1234.1234.co.ke", path: "/1234.php"),
        accountReference: 'Mpesa Demo',
        phoneNumber: phoneNumber,
        baseUri: Uri(scheme: "https", host: "sandbox.safaricom.co.ke"),
        transactionDesc: 'Mpesa demo',
        passKey:
            'bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919',
        amount: amount,
      );

      if (result.success) {
        print('STK Push successful');
        // do something if success, like showing a success message
      } else {
        print('STK Push failed');
        // show an error message
      }
    } catch (e) {
      print('Error: $e');
      // show an error message
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    // print(SizeConfig.screenHeight);
    // print(SizeConfig.screenWidth);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Make Payment'),
      ),
      body: Center(
        child: Form(
          // key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Mpesa Demo Trials",
                style: headingStyle,
              ),
              Container(
                height: getScreenHeight(115),
                width: getScreenWidth(300),
                color: Colors.orange,
              ),
              SizedBox(height: 15),
              TextFormField(
                decoration: InputDecoration(
                  prefixText: '254',
                  contentPadding:
                      const EdgeInsets.only(top: 9, bottom: 9, left: 20),
                  labelText: "Enter Your Mpesa Number",
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
                    _mpesaNumber = '254$value';
                  });
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.only(top: 9, bottom: 9, left: 20),
                  labelText: "Enter Amount",
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
                onChanged: (value) {
                  setState(() {
                    _amount = double.parse(value);
                  });
                },
              ),
              TextButton(
                onPressed: () async {
                  startTransaction(amount: _amount, phoneNumber: _mpesaNumber);
                },
                child: const Text('Make Payment'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
