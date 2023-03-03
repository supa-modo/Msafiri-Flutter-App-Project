import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';

import '../../../constants/constants.dart';
import '../../../size_config/size_config.dart';
import 'hhtp.dart';

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
  // final TextEditingController _phoneNumberField = TextEditingController();
  // final TextEditingController _amountField = TextEditingController();

  Future<void> startCheckout(
      {required String userPhone, required double amount}) async {
    //Preferably expect 'dynamic', response type varies a lot!
    dynamic transactionInitialisation;

    try {
      transactionInitialisation = await MpesaFlutterPlugin.initializeMpesaSTKPush(
          businessShortCode: partyB,
          transactionType: TransactionType.CustomerPayBillOnline,
          amount: amount,
          partyA: userPhone,
          partyB: partyB,
          callBackURL:
              Uri(scheme: "https", host: "1234.1234.co.ke", path: "/1234.php"),
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

  Future<dynamic> startTransaction(
      {required double amount, required String phoneNumber}) async {
    dynamic transactionInitialization;
    try {
      transactionInitialization =
          await MpesaFlutterPlugin.initializeMpesaSTKPush(
        businessShortCode: '174379',
        transactionType: TransactionType
            .CustomerPayBillOnline, //or CustomerBuyGoodsOnline for till numbers
        partyA: phoneNumber,
        partyB: '174379',
        callBackURL: Uri(
            scheme: 'https',
            host:
                'us-central1-pts-project-x2.cloudfunctions.net/mpesaCallback'),
        accountReference: 'Mpesa Demo',
        phoneNumber: phoneNumber,
        baseUri: Uri(scheme: "https", host: "sandbox.safaricom.co.ke"),
        // transactionDesc: 'Mpesa demo',
        passKey:
            'bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919',
        amount: amount,
      );

      FirebaseFirestore.instance.collection(partyB).add({
        'amount': amount,
        'phoneNumber': phoneNumber,
        'transactionDetails': transactionInitialization
      });

      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection(partyB).get();
      List<DocumentSnapshot> documents = querySnapshot.docs;
      documents.forEach((document) {
        print('Transaction Details: ${document.data()}');
      });

      // if (result.success) {
      //   print('STK Push successful');
      //   // do something if success, like showing a success message
      // } else {
      //   print('STK Push failed');
      //   // show an error message
      // }
    } catch (e) {
      print('Error: $e');
      // show an error message
    }
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   _phoneNumberField.dispose();
  //   _amountField.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Make Payment'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
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
                // controller: _phoneNumberField,
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
                // controller: _amountField,
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
                  // startTransaction(amount: 1, phoneNumber: '254790193402');
                  startCheckout(userPhone: _mpesaNumber, amount: _amount);
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
