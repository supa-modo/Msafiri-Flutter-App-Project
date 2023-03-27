import 'package:flutter/material.dart';
import 'package:project_x/src/features/screens/new_trip/place_autocompl.dart';

import '../../../common_widgets/defaultButton.dart';
import '../../../constants/constants.dart';
import '../../../size_config/size_config.dart';
import '../Map Screen/mapScreen2.dart';
import '../payment/payment.dart';

class SearchLocationScreen extends StatefulWidget {
  const SearchLocationScreen({Key? key, this.pressed}) : super(key: key);
  final VoidCallback? pressed;

  @override
  State<SearchLocationScreen> createState() => _SearchLocationScreenState();
}

class _SearchLocationScreenState extends State<SearchLocationScreen> {
  bool mPesa = true;
  bool cash = false;
  String _mpesaNumber = '';
  bool _validateMpesaNumber = false;

  @override
  Widget build(BuildContext context) {
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
          "New Trip",
          style: TextStyle(color: Color.fromARGB(255, 95, 94, 94)),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text(
              "Set Your Desination",
              style: TextStyle(
                color: appPrimaryColor,
                fontSize: getScreenWidth(18),
                fontWeight: FontWeight.bold,
              ),
            ),
            SearchScreen(),
            Container(),
            SizedBox(height: getScreenHeight(20)),
            Text(
              "Select Payment Method",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: getScreenWidth(15),
                  color: appPrimaryColor),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: getScreenWidth(20)),
              child: Row(children: <Widget>[
                Checkbox(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  value: mPesa,
                  onChanged: (value) {
                    setState(() {
                      mPesa = value!;
                      cash = false;
                    });
                  },
                ),
                Text(
                  "Mpesa Transaction",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: getScreenWidth(14)),
                ),
                SizedBox(width: getScreenWidth(25)),
                Checkbox(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  value: cash,
                  onChanged: (value) {
                    setState(() {
                      mPesa = false;
                      cash = value!;
                    });
                  },
                ),
                Text(
                  "Cash Money",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: getScreenWidth(14)),
                ),
              ]),
            ),
            SizedBox(height: getScreenHeight(15)),
            mPesa
                ? Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: getScreenWidth(20)),
                    child: Column(
                      children: [
                        SizedBox(
                          height: getScreenHeight(70),
                          child: TextFormField(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                top: getScreenHeight(5),
                                bottom: getScreenHeight(5),
                                left: getScreenWidth(20),
                              ),
                              labelText: "Enter Your Mpesa Number",
                              prefixText: '+254',
                              labelStyle: TextStyle(
                                fontSize: getScreenWidth(14),
                                fontWeight: FontWeight.w600,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:
                                    const BorderSide(color: appPrimaryColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:
                                    const BorderSide(color: appPrimaryColor),
                              ),
                              errorText: _validateMpesaNumber
                                  ? "Enter a valid phone number"
                                  : null,
                            ),
                            keyboardType: TextInputType.number,
                            maxLength: 9,
                            onChanged: (value) {
                              setState(() {
                                _mpesaNumber = '254$value';
                                _validateMpesaNumber = false;
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: getScreenWidth(60),
                            right: getScreenWidth(60),
                            top: getScreenHeight(10),
                            bottom: getScreenHeight(10),
                          ),
                          child: DefaultButton(
                            pressed: () {
                              if (_mpesaNumber.isEmpty) {
                                setState(() {
                                  _validateMpesaNumber = true;
                                });
                              } else if (_mpesaNumber.length != 12) {
                                setState(() {
                                  _validateMpesaNumber = true;
                                });
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        QRScanScreen(mpesaNumber: _mpesaNumber),
                                  ),
                                );
                              }
                            },
                            text: "Continue to Payment",
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: getScreenWidth(20)),
                  ),
            cash
                ? Column(
                    children: [
                      Text("!! Ensure you pay your cash before alighting !!",
                          style: TextStyle(
                            fontSize: getScreenWidth(16),
                            color: Colors.red,
                          )),
                      Padding(
                        padding: EdgeInsets.only(
                            left: getScreenWidth(100),
                            right: getScreenWidth(100),
                            top: getScreenHeight(35),
                            bottom: getScreenHeight(10)),
                        child: DefaultButton(
                          pressed: () {},
                          text: "Finish",
                        ),
                      ),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
