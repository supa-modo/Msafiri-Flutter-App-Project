import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_x/src/size_config/size_config.dart';
import '../../../constants/constants.dart';
import '../home_screen/home_screen.dart';

class PaymentSuccessful extends StatefulWidget {
  final String checkOutRequestID;
  final String partyB;

  PaymentSuccessful(
      {super.key, required this.checkOutRequestID, required this.partyB});

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
  String partyB = "";

  @override
  void initState() {
    super.initState();
    checkOutRequestID = widget.checkOutRequestID;
    partyB = widget.partyB;
    fetchTransactionDetails(checkOutRequestID);
  }

  String convertDateFormat(String input) {
    String year = input.substring(0, 4);
    String month = input.substring(4, 6);
    String day = input.substring(6, 8);
    String hour = input.substring(8, 10);
    String minute = input.substring(10, 12);

    String output = "$day/$month/$year $hour:$minute";
    return output;
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
      if (data != null &&
          data.containsKey("Destination") &&
          data.containsKey("amount") &&
          data.containsKey("mpesaReceiptNumber") &&
          data.containsKey("transactionDate")) {
        destination = data["Destination"] ?? 'Not set';
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
    } else {
      await Future.delayed(Duration(seconds: 2));
      fetchTransactionDetails(checkOutRequestID);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(color: appPrimaryColor),
                SizedBox(height: getScreenHeight(10)),
                Text(
                  'Processing payment, please wait...',
                  style: TextStyle(color: appPrimaryColor),
                ),
              ],
            ))
          : Container(
              padding: const EdgeInsets.only(left: 60, right: 60, top: 150),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Transaction Code: ",
                        style: TextStyle(
                            fontSize: 14.0,
                            color: Color.fromARGB(255, 52, 52, 54)),
                      ),
                      Text(
                        "$mpesaReceiptNumber",
                        style: const TextStyle(
                            fontSize: 15.0,
                            color: Colors.green,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Date: ",
                        style: TextStyle(
                            fontSize: 14.0,
                            color: Color.fromARGB(255, 52, 52, 54)),
                      ),
                      Text(
                        convertDateFormat(transactionDate.toString()),
                        style: const TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Destination: ",
                        style: TextStyle(
                            fontSize: 14.0,
                            color: Color.fromARGB(255, 52, 52, 54)),
                      ),
                      Text(
                        destination,
                        style: const TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.bold),
                      ),
                    ],
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
                            fontSize: 15.0,
                            color: Colors.red,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: getScreenHeight(10)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Paid to: ",
                        style: TextStyle(
                            fontSize: 14.0,
                            color: Color.fromARGB(255, 52, 52, 54)),
                      ),
                      Text(
                        partyB,
                        style: const TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.bold),
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
