import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> getData() async {
  final response = await http.get(
    Uri.parse(
        'https://us-central1-pts-project-x2.cloudfunctions.net/mpesaCallback'),
  );

  if (response.statusCode == 200) {
    // Parse the response body
    final data = json.decode(response.body);

    // Access the transaction data
    final transactionDate = data['transactionDate'];
    final phoneNumber = data['phoneNumber'];
    final amount = data['amount'];
    final mpesaReceiptNumber = data['mpesaReceiptNumber'];

    // Do something with the transaction data
    print('Transaction details:');
    print('Transaction date: $transactionDate');
    print('Phone number: $phoneNumber');
    print('Amount: $amount');
    print('Mpesa receipt number: $mpesaReceiptNumber');
  } else {
    throw Exception('Failed to retrieve data');
  }
}
