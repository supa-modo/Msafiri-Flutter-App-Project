import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_x/src/size_config/size_config.dart';

import '../../../constants/constants.dart';
import 'package:intl/intl.dart';

class PaymentsListScreen extends StatefulWidget {
  const PaymentsListScreen({super.key});

  @override
  _PaymentsListScreenState createState() => _PaymentsListScreenState();
}

class _PaymentsListScreenState extends State<PaymentsListScreen> {
  final List<Transaction> transactions = [];

  @override
  void initState() {
    super.initState();
    fetchTransactions();
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

  void fetchTransactions() async {
    final QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('mobileTransactions').get();

    final List<Transaction> fetchedTransactions = snapshot.docs.map((doc) {
      final Map<String, dynamic> data = doc.data();
      return Transaction(
        transactionCode: data['mpesaReceiptNumber'] as String,
        phoneNumber: data['phoneNumber'] as int,
        name: data['Name'] as String,
        destination: "Paybill 1234",
        amount: data['amount'] as int,
        dateTime: data['transactionDate'] as int,
      );
    }).toList();

    setState(() {
      transactions.addAll(fetchedTransactions);
    });
  }

  final selectedRows = <Transaction>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appPrimaryColor,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Color.fromARGB(255, 53, 121, 238),
          statusBarIconBrightness: Brightness.dark,
        ),
        centerTitle: true,
        title: const Text("Payments to your account"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.only(left: 1, right: 5),
            child: DataTable(
              horizontalMargin: 3,
              dividerThickness: 2,
              showCheckboxColumn: false,
              headingRowHeight: getScreenHeight(45),
              headingRowColor: MaterialStateColor.resolveWith(
                  (states) => Color.fromARGB(253, 0, 47, 100).withOpacity(0.5)),
              headingTextStyle: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Color.fromARGB(255, 5, 182, 79)
                      : Color.fromARGB(255, 255, 255, 255),
                  fontSize: getScreenWidth(15),
                  fontWeight: FontWeight.w400),
              dataTextStyle: TextStyle(
                  // fontFamily: 'Consolas',
                  fontSize: 14.5,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Color.fromARGB(255, 19, 18, 18)),
              border: const TableBorder(
                  right: BorderSide(color: Color.fromARGB(255, 116, 114, 114)),
                  left: BorderSide(color: Color.fromARGB(255, 116, 114, 114)),
                  top: BorderSide(color: Color.fromARGB(255, 116, 114, 114)),
                  bottom:
                      BorderSide(color: Color.fromARGB(255, 116, 114, 114))),
              columnSpacing: 5.0,
              columns: const [
                DataColumn(label: Text("SELECT")),
                DataColumn(label: Text("NAME")),
                DataColumn(label: Text("TRANSACTION CODE")),
                DataColumn(label: Text("PHONE NUMBER")),
                DataColumn(label: Text("DESTINATION")),
                DataColumn(label: Text("AMOUNT")),
                DataColumn(label: Text("DATE/TIME"))
              ],
              rows: transactions
                  .map((txn) => DataRow(
                          selected: selectedRows.contains(txn),
                          onSelectChanged: (bool? selected) {
                            setState(() {
                              if (selected != null) {
                                if (selected) {
                                  selectedRows.add(txn);
                                } else {
                                  selectedRows.remove(txn);
                                }
                              }
                            });
                          },
                          cells: [
                            DataCell(
                              Checkbox(
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                ),
                                value: selectedRows.contains(txn),
                                onChanged: (bool? value) {
                                  setState(() {
                                    if (value!) {
                                      selectedRows.add(txn);
                                      transactions.remove(txn);
                                      transactions.add(txn);
                                    } else {
                                      selectedRows.remove(txn);
                                    }
                                  });
                                },
                              ),
                            ),
                            DataCell(
                              Container(
                                color: selectedRows.contains(txn)
                                    ? const Color.fromARGB(255, 248, 150, 150)
                                    : null,
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  txn.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            DataCell(
                              Container(
                                color: selectedRows.contains(txn)
                                    ? const Color.fromARGB(255, 248, 150, 150)
                                    : null,
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  txn.transactionCode,
                                  style: const TextStyle(),
                                ),
                              ),
                            ),
                            DataCell(
                              Container(
                                color: selectedRows.contains(txn)
                                    ? const Color.fromARGB(255, 248, 150, 150)
                                    : null,
                                padding: const EdgeInsets.all(8),
                                child: Text(txn.phoneNumber.toString()),
                              ),
                            ),
                            DataCell(
                              Container(
                                color: selectedRows.contains(txn)
                                    ? const Color.fromARGB(255, 248, 150, 150)
                                    : null,
                                padding: const EdgeInsets.all(8),
                                child: Text(txn.destination,
                                    style:
                                        const TextStyle(color: Colors.green)),
                              ),
                            ),
                            DataCell(
                              Container(
                                color: selectedRows.contains(txn)
                                    ? const Color.fromARGB(255, 248, 150, 150)
                                    : null,
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  "Kshs. ${txn.amount}",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 230, 44, 44)),
                                ),
                              ),
                            ),
                            DataCell(
                              Container(
                                color: selectedRows.contains(txn)
                                    ? const Color.fromARGB(255, 248, 150, 150)
                                    : null,
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                    convertDateFormat(txn.dateTime.toString())),
                              ),
                            ),
                          ]))
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}

class Transaction {
  final String transactionCode;
  final String name;
  final int phoneNumber;
  final String destination;
  final int amount;
  final int dateTime;

  Transaction({
    required this.transactionCode,
    required this.name,
    required this.phoneNumber,
    required this.destination,
    required this.amount,
    required this.dateTime,
  });
}
