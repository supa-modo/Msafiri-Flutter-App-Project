// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// import '../home_screen/home_screen.dart';

// class PaymentSuccessful extends StatefulWidget {
//   final String checkOutRequestID;
//   PaymentSuccessful({
//     super.key,
//     required this.checkOutRequestID,
//   });

//   @override
//   State<PaymentSuccessful> createState() => _PaymentSuccessfulState();
// }

// class _PaymentSuccessfulState extends State<PaymentSuccessful> {
//   final String destination = "Kabu Main Gate";
//   final int _transactionDate = 20230319112304;
//   final String _mpesaReceiptNumber = 'OAXDFRTILVV';
//   final int _amount = 200;
//   bool _isLoading = true;
//   late String _checkOutRequestID;

//   String convertDateFormat(String input) {
//     String year = input.substring(0, 4);
//     String month = input.substring(4, 6);
//     String day = input.substring(6, 8);
//     String hour = input.substring(8, 10);
//     String minute = input.substring(10, 12);

//     String output = "$day/$month/$year $hour:$minute";
//     return output;
//   }

//   @override
//   void initState() {
//     super.initState();
//     _isLoading = false;
//     // fetchTransactionDetails(_checkoutRequestID);
//     _checkOutRequestID = widget.checkOutRequestID;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: _isLoading
//             ? Center(child: CircularProgressIndicator())
//             : Container(
//                 padding: const EdgeInsets.only(left: 60, right: 60, top: 200),
//                 child: Column(
//                   children: <Widget>[
//                     const SizedBox(
//                         height: 120,
//                         width: 240,
//                         child: Image(
//                             image: AssetImage("assets/images/success.png"))),
//                     const SizedBox(height: 20.0),
//                     const Text(
//                       "Your payment was successful!",
//                       style: TextStyle(
//                           fontSize: 18.0,
//                           fontWeight: FontWeight.bold,
//                           color: Color.fromARGB(255, 53, 53, 53)),
//                     ),
//                     const SizedBox(height: 20.0),
//                     Text(
//                       "Transaction Code: 1234",
//                       style: const TextStyle(
//                           fontSize: 14.0,
//                           color: Color.fromARGB(255, 52, 52, 54),
//                           fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(height: 10.0),
//                     Text(
//                       "Destination: $destination",
//                       style: const TextStyle(
//                           fontSize: 14.0,
//                           color: Color.fromARGB(255, 52, 52, 54)),
//                     ),
//                     const SizedBox(height: 10.0),
//                     Text(
//                       "Date: $_transactionDate",
//                       style: const TextStyle(
//                           fontSize: 14.0,
//                           color: Color.fromARGB(255, 52, 52, 54)),
//                     ),
//                     const SizedBox(height: 10.0),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Text(
//                           "Amount paid: ",
//                           style: TextStyle(
//                               fontSize: 14.0,
//                               color: Color.fromARGB(255, 52, 52, 54)),
//                         ),
//                         Text(
//                           "Kshs. $_amount",
//                           style: const TextStyle(
//                               fontSize: 14.0,
//                               color: Colors.red,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 20.0),
//                     ElevatedButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => HomeScreen(),
//                           ),
//                         );
//                       },
//                       child: const Text('Back to Home'),
//                     ),
//                   ],
//                 ),
//               ));
//   }
// }
