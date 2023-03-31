import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../../../common_widgets/defaultButton.dart';
import '../../../constants/constants.dart';
import '../../../size_config/size_config.dart';

class MyHomePage1 extends StatefulWidget {
  @override
  _MyHomePage1State createState() => _MyHomePage1State();
}

class _MyHomePage1State extends State<MyHomePage1> {
  String userMail = FirebaseAuth.instance.currentUser!.email ?? "Null email";
  String _mpesaNumber = '';
  double _amount = 1;
  String partyB = '174379';

  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;
  bool _error = false;

  Future<void> updateAccount(String transCheckoutRequestID) async {
    final initData = {
      'CheckoutRequestID': transCheckoutRequestID,
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
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Mpesa STK Push Demo"),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(
            horizontal: getScreenWidth(20),
            vertical: getScreenHeight(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter your Mpesa Number',
                  labelText: 'Mpesa Number',
                ),
                onChanged: (value) {
                  setState(() {
                    _mpesaNumber = value;
                  });
                },
              ),
              SizedBox(height: getScreenHeight(20)),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter Amount',
                  labelText: 'Amount',
                ),
                onChanged: (value) {
                  setState(() {
                    _amount = double.tryParse(value) ?? 1;
                  });
                },
              ),
              SizedBox(height: getScreenHeight(20)),
              DefaultButton(
                text: 'Pay Now',
                pressed: () async {
                  // await startTransaction(
                  //   userPhone: _mpesaNumber,
                  //   amount: _amount,
                  // );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
