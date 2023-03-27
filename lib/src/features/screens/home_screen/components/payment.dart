import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/constants.dart';
import '../../../../size_config/size_config.dart';
import '../../payment/payment.dart';

class payment extends StatelessWidget {
  const payment({
    Key? key,
  }) : super(key: key);

  Future<String> getUserPhone() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    final DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();

    final String phoneNumber = userDoc.get('phoneNumber');
    return phoneNumber;
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        String phoneNumber =
            await getUserPhone(); // Call getUserPhone and get the phone number
        Get.to(() => QRScanScreen(mpesaNumber: phoneNumber));
      },
      child: Column(
        children: [
          Container(
            height: getScreenHeight(130),
            width: getScreenWidth(165),
            decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  opacity: 0.8,
                  image: AssetImage("assets/images/payment.jpg")),
              color: appPrimaryColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                color: Color.fromARGB(255, 101, 170, 235)),
            height: getScreenHeight(40),
            width: getScreenWidth(165),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: getScreenWidth(15)),
                  child: Text("Payment",
                      style: TextStyle(
                          fontSize: getScreenWidth(19),
                          fontWeight: FontWeight.w900,
                          color: const Color.fromARGB(200, 49, 49, 49))),
                ),
                Padding(
                  padding: EdgeInsets.only(right: getScreenWidth(5)),
                  child: Icon(
                    color: const Color.fromARGB(200, 49, 49, 49),
                    Icons.arrow_forward,
                    size: getScreenWidth(28),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
