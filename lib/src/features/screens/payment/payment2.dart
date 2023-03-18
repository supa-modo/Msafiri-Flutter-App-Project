import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../size_config/size_config.dart';
import 'components/qrScanScreen.dart';
import 'payment_options.dart';

class QRScanScreen1 extends StatefulWidget {
  final String mpesaNumber;
  const QRScanScreen1({super.key, required this.mpesaNumber});

  @override
  State<QRScanScreen1> createState() => _QRScanScreenState1();
}

final _paymentDetailsController = TextEditingController();

class _QRScanScreenState1 extends State<QRScanScreen1> {
  bool pDetails = false;
  String? _scannedText;
  String _jsonData = '';
  late String _mpesaNumber;

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
      String qrText =
          result; // Replace this with the actual QR scanned text string

      String transactionType = '';
      String paymentNumber = '';
      String accountReference = '';

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

      // Create a map with key-value pairs for the variables
      Map<String, dynamic> qrData = {
        'transactionType': transactionType,
        'paymentNumber': paymentNumber,
        'accountReference': accountReference
      };

      // Convert the map into a JSON format using json.encode
      _jsonData = json.encode(qrData);
      print(_jsonData); // Output: Account Reference: KBZ679Y
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
                          onChanged: (_jsonData == null)
                              ? null
                              : (value) {
                                  setState(() {
                                    pDetails = value!;
                                  });
                                },
                        )
                      ],
                    ),
                    SizedBox(height: getScreenHeight(5)),
                    CheckboxRow(
                        pDetails: pDetails,
                        jsonData: _jsonData,
                        mpesaNumber: _mpesaNumber),
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
