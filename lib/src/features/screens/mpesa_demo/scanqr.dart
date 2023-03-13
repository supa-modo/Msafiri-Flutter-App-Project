import 'package:flutter/material.dart';

import '../payment/components/qrScanScreen.dart';
import 'qrdemo4.dart';

class QRCodeScannerScreen1 extends StatefulWidget {
  @override
  _QRCodeScannerScreen1State createState() => _QRCodeScannerScreen1State();
}

class _QRCodeScannerScreen1State extends State<QRCodeScannerScreen1> {
  String _scannedText = '';

  void _onScanQRCodePressed() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QRCodeScannerScreen(),
      ),
    );

    setState(() {
      _scannedText = result ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Scanner'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: TextButton(
              onPressed: _onScanQRCodePressed,
              child: Text('Scan QR Code'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _scannedText.isNotEmpty
                      ? 'Scanned Text: $_scannedText'
                      : 'No QR code scanned yet',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
