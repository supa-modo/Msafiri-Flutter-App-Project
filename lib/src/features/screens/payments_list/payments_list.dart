import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../constants/constants.dart';

class PaymentsListScreen extends StatefulWidget {
  const PaymentsListScreen({super.key});

  @override
  _PaymentsListScreenState createState() => _PaymentsListScreenState();
}

class _PaymentsListScreenState extends State<PaymentsListScreen> {
  final List<Transaction> transactions = [
    Transaction(
      name: "John Doe",
      destination: "Paybill 1234",
      amount: 100,
      time: "10:00 AM",
      date: "01/01/2022",
    ),
    Transaction(
      name: "Jane Smith",
      destination: "Tillnumber 5678",
      amount: 200,
      time: "11:00 AM",
      date: "01/01/2022",
    ),
    Transaction(
        name: "Mike Johnson",
        destination: "Paybill 1234",
        amount: 50,
        time: "12:00 PM",
        date: "01/01/2022"),
    Transaction(
        name: "Jessica Williams",
        destination: "Tillnumber 5678",
        amount: 75,
        time: "1:00 PM",
        date: "01/01/2022"),
    Transaction(
        name: "James Brown",
        destination: "Paybill 1234",
        amount: 125,
        time: "2:00 PM",
        date: "01/01/2022"),
    Transaction(
        name: "Mary Jones",
        destination: "Tillnumber 5678",
        amount: 150,
        time: "3:00 PM",
        date: "01/01/2022"),
    Transaction(
        name: "David Garcia",
        destination: "Paybill 1234",
        amount: 175,
        time: "4:00 PM",
        date: "01/01/2022"),
    Transaction(
        name: "Maria Rodriguez",
        destination: "Tillnumber 5678",
        amount: 200,
        time: "5:00 PM",
        date: "01/01/2022"),
    Transaction(
        name: "William Martinez",
        destination: "Paybill 1234",
        amount: 225,
        time: "6:00 PM",
        date: "01/01/2022"),
    Transaction(
        name: "Elizabeth Taylor",
        destination: "Tillnumber 5678",
        amount: 250,
        time: "7:00 PM",
        date: "01/01/2022"),
    Transaction(
        name: "Richard Hernandez",
        destination: "Paybill 1234",
        amount: 275,
        time: "8:00 PM",
        date: "01/01/2022"),
    Transaction(
        name: "Samantha Perez",
        destination: "Tillnumber 5678",
        amount: 300,
        time: "9:00 PM",
        date: "01/01/2022"),
    Transaction(
        name: "Richard Hernandez",
        destination: "Paybill 1234",
        amount: 275,
        time: "8:00 PM",
        date: "01/01/2022"),
    Transaction(
        name: "Samantha Perez",
        destination: "Tillnumber 5678",
        amount: 300,
        time: "9:00 PM",
        date: "01/01/2022"),
  ];

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
            padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
            child: DataTable(
              horizontalMargin: 3,
              showCheckboxColumn: false,
              headingTextStyle: const TextStyle(
                  color: Color.fromARGB(255, 44, 44, 44),
                  fontWeight: FontWeight.bold),
              dataTextStyle: TextStyle(
                  fontFamily: 'Consolas',
                  fontSize: 13,
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
                DataColumn(label: Text("Select")),
                DataColumn(label: Text("Name")),
                DataColumn(label: Text("Destination")),
                DataColumn(label: Text("Amount")),
                DataColumn(label: Text("Time")),
                DataColumn(label: Text("Date"))
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
                                child: Text(txn.destination),
                              ),
                            ),
                            DataCell(
                              Container(
                                color: selectedRows.contains(txn)
                                    ? const Color.fromARGB(255, 248, 150, 150)
                                    : null,
                                padding: const EdgeInsets.all(8),
                                child: Text("Kshs. ${txn.amount}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromARGB(255, 230, 44, 44))),
                              ),
                            ),
                            DataCell(
                              Container(
                                color: selectedRows.contains(txn)
                                    ? const Color.fromARGB(255, 248, 150, 150)
                                    : null,
                                padding: const EdgeInsets.all(8),
                                child: Text(txn.time),
                              ),
                            ),
                            DataCell(
                              Container(
                                color: selectedRows.contains(txn)
                                    ? const Color.fromARGB(255, 248, 150, 150)
                                    : null,
                                padding: const EdgeInsets.all(8),
                                child: Text(txn.date),
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
  final String name;
  final String destination;
  final double amount;
  final String time;
  final String date;

  Transaction(
      {required this.name,
      required this.destination,
      required this.amount,
      required this.time,
      required this.date});
}
