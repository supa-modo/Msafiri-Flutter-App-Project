import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';

Future<dynamic> startTransaction(
    {required double amount,
    required String phoneNumber,
    required bool isPaybill,
    required String paybillNumber,
    required String tillNumber,
    required String accountNumber}) async {
  try {
    String partyB, businessShortCode;
    TransactionType transactionType;

    if (isPaybill) {
      partyB = paybillNumber;
      businessShortCode = paybillNumber;
      transactionType = TransactionType.CustomerPayBillOnline;
    } else {
      partyB = businessShortCode = tillNumber;
      transactionType = TransactionType.CustomerBuyGoodsOnline;
    }

    final result = await MpesaFlutterPlugin.initializeMpesaSTKPush(
      businessShortCode: businessShortCode,
      transactionType: transactionType,
      partyA: phoneNumber,
      partyB: partyB,
      callBackURL: Uri.parse(
          'https://us-central1-pts-project-x2.cloudfunctions.net/saveMpesaTransaction'),
      accountReference: accountNumber,
      phoneNumber: phoneNumber,
      baseUri: Uri(scheme: "https", host: "sandbox.safaricom.co.ke"),
      transactionDesc: 'Mpesa demo',
      passKey:
          'bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919',
      amount: amount,
    );
  } catch (e) {
    print('Error: $e');
    // show an error message
  }
}
