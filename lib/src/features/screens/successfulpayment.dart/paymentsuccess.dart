import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../home_screen/home_screen.dart';

class PaymentSuccessful extends StatefulWidget {
  final String phonePaidFrom;
  final String amount;
  final String mpesaReceiptNumber;
  final String transactionDate;

  PaymentSuccessful(
      {super.key,
      required this.transactionDate,
      required this.phonePaidFrom,
      required this.amount,
      required this.mpesaReceiptNumber});

  @override
  State<PaymentSuccessful> createState() => _PaymentSuccessfulState();
}

class _PaymentSuccessfulState extends State<PaymentSuccessful> {
  final String destination = "Kabu Main Gate";
  late String _transactionDate;
  late String _mpesaReceiptNumber;
  late String _amount;
  late String _phonePaidFrom;

  @override
  void initState() {
    super.initState();
    _transactionDate = widget.transactionDate;
    _mpesaReceiptNumber = widget.mpesaReceiptNumber;
    _amount = widget.amount;
    _phonePaidFrom = widget.phonePaidFrom;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.only(left: 65, right: 65, top: 200),
      child: Column(
        children: <Widget>[
          const SizedBox(
              height: 120,
              width: 240,
              child: Image(image: AssetImage("assets/images/success.png"))),
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
            "Transaction Code: $_mpesaReceiptNumber",
            style: const TextStyle(
                fontSize: 14.0,
                color: Color.fromARGB(255, 52, 52, 54),
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10.0),
          Text(
            "Date: $_transactionDate",
            style: const TextStyle(
                fontSize: 14.0, color: Color.fromARGB(255, 52, 52, 54)),
          ),
          const SizedBox(height: 10.0),
          Text(
            "Destination: $destination",
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
                    fontSize: 14.0, color: Color.fromARGB(255, 52, 52, 54)),
              ),
              Text(
                "Kshs. $_amount",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                    color: Color.fromARGB(255, 206, 38, 38)),
              ),
            ],
          ),
          const SizedBox(height: 250),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 65),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromARGB(255, 81, 81, 82)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25))),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeScreen()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.home,
                    color: Colors.white,
                    size: 30,
                  ),
                  SizedBox(width: 5),
                  Text("Home",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ))
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}
