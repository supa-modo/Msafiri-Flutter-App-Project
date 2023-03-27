import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../home_screen/home_screen.dart';

class PaymentSuccessful extends StatefulWidget {
  final String checkOutRequestID;

  PaymentSuccessful({super.key, required this.checkOutRequestID});

  @override
  State createState() => _PaymentSuccessfulState();
}

class _PaymentSuccessfulState extends State<PaymentSuccessful> {
  String destination = "";
  int transactionDate = 0;
  String mpesaReceiptNumber = "";
  int amount = 0;
  bool isLoading = true;
  String checkOutRequestID = "";

  @override
  void initState() {
    super.initState();
    checkOutRequestID = widget.checkOutRequestID;
    fetchTransactionDetails(checkOutRequestID);
  }

  Future<void> fetchTransactionDetails(String checkOutRequestID) async {
    // show circular progress indicator until details are fetched
    setState(() {
      isLoading = true;
    });

    final firestore = FirebaseFirestore.instance;
    final doc = await firestore
        .collection('mobileTransactions')
        .doc(checkOutRequestID)
        .get();

    if (doc.exists) {
      final data = doc.data();
      destination = data!["Destination"] ?? 'Not set';
      transactionDate = data["transactionDate"];
      mpesaReceiptNumber = data["mpesaReceiptNumber"];
      amount = data["amount"];

      // update state and remove circular progress indicator
      setState(() {
        isLoading = false;
      });
    } else {
      // wait for 1 minute and try again
      await Future.delayed(Duration(seconds: 5));
      fetchTransactionDetails(checkOutRequestID);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
              padding: const EdgeInsets.only(left: 60, right: 60, top: 200),
              child: Column(
                children: [
                  const SizedBox(
                      height: 120,
                      width: 240,
                      child: Image(
                          image: AssetImage("assets/images/success.png"))),
                  const SizedBox(height: 20.0),
                  const Text(
                    "Your payment was successful!",
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 53, 53, 53)),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    "Transaction Code: $mpesaReceiptNumber",
                    style: const TextStyle(
                        fontSize: 14.0,
                        color: Color.fromARGB(255, 52, 52, 54),
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    "Destination: $destination",
                    style: const TextStyle(
                        fontSize: 14.0, color: Color.fromARGB(255, 52, 52, 54)),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    "Date: $transactionDate",
                    style: const TextStyle(
                        fontSize: 14.0, color: Color.fromARGB(255, 52, 52, 54)),
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Amount paid: ",
                        style: TextStyle(
                            fontSize: 14.0,
                            color: Color.fromARGB(255, 52, 52, 54)),
                      ),
                      Text(
                        "Kshs. $amount",
                        style: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.red,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    },
                    child: const Text('Back to Home'),
                  ),
                ],
              ),
            ),
    );
  }
}
