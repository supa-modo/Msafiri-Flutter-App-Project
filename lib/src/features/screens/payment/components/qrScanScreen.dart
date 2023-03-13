import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../../size_config/size_config.dart';

class QRCodeScannerScreen extends StatefulWidget {
  @override
  _QRCodeScannerScreenState createState() => _QRCodeScannerScreenState();
}

class _QRCodeScannerScreenState extends State<QRCodeScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  bool _torchEnabled = false;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
              borderColor: const Color.fromARGB(255, 207, 14, 0),
              borderRadius: getScreenWidth(10),
              borderLength: 30,
              borderWidth: getScreenWidth(10),
              cutOutSize: getScreenWidth(300),
            ),
          ),
          Positioned(
            top: getScreenHeight(50),
            left: getScreenWidth(20),
            child: IconButton(
              icon: Icon(Icons.close,
                  color: Colors.white, size: getScreenWidth(30)),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Positioned(
            top: getScreenHeight(50),
            right: getScreenWidth(20),
            child: IconButton(
              icon: _torchEnabled
                  ? Icon(Icons.flash_on,
                      color: Colors.white, size: getScreenWidth(30))
                  : Icon(Icons.flash_off,
                      color: Colors.white, size: getScreenWidth(30)),
              onPressed: () {
                setState(() {
                  _torchEnabled = !_torchEnabled;
                });
                controller?.toggleFlash();
              },
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.pauseCamera();
    controller.resumeCamera();
    controller.scannedDataStream.listen((scanData) {
      HapticFeedback.lightImpact();
      setState(() {
        Navigator.pop(context, scanData.code);
        controller.pauseCamera();
      });
    });
  }
}
