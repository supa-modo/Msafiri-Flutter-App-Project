import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../constants/constants.dart';
import '../../../size_config/size_config.dart';
import 'payment_options.dart';

import 'package:get/get.dart';

import 'qr_screen.dart';

class QRScanScreen1 extends StatefulWidget {
  const QRScanScreen1({super.key});

  @override
  State<QRScanScreen1> createState() => _QRScanScreenState1();
}

final _paymentDetailsController = TextEditingController();

class _QRScanScreenState1 extends State<QRScanScreen1> {
  bool pDetails = true;
  @override
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
                                onPressed: () {
                                  Get.to(() => QrCodeScanScreen2());
                                },
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
                          fontWeight: FontWeight.bold,
                          fontSize: getScreenWidth(14)),
                    ),
                    SizedBox(height: getScreenHeight(10)),
                    Container(
                      height: getScreenHeight(55),
                      width: getScreenWidth(400),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 190, 190, 190),
                          borderRadius: BorderRadius.circular(15)),
                      child: FutureBuilder(
                        future: Future.delayed(Duration.zero),
                        builder: (context, snapshot) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: getScreenWidth(20),
                                vertical: getScreenHeight(15)),
                            child: TextFormField(
                              initialValue:
                                  "!! Payment details not available for now !!",
                              style: TextStyle(
                                  fontSize: getScreenWidth(13),
                                  color: Colors.red),
                              enabled: true,
                            ),
                          );
                        },
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                            ),
                            value: pDetails,
                            onChanged: (value) {
                              setState(() {
                                pDetails = value!;
                              });
                            })
                      ],
                    ),
                    SizedBox(height: getScreenHeight(5)),
                    CheckboxRow(pDetails: pDetails)
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // @override
  // void dispose() {
  //   _paymentDetailsController.dispose();
  //   super.dispose();
  // }
}
