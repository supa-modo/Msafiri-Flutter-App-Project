import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../size_config/size_config.dart';

class QrCodeScanScreen2 extends StatefulWidget {
  const QrCodeScanScreen2({super.key});

  @override
  _QrCodeScanScreen2State createState() => _QrCodeScanScreen2State();
}

class _QrCodeScanScreen2State extends State<QrCodeScanScreen2> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController _controller;
  bool _torchEnabled = false;

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this._controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      Navigator.pop(
          context, scanData); // Pass the scanData to the parent screen
    });
    controller.pauseCamera();
    controller.resumeCamera();
  }

  @override
  void dispose() {
    _controller.dispose();
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
            cameraFacing: CameraFacing.back,
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
              onPressed: () async {
                try {
                  _torchEnabled = !_torchEnabled;
                  await _controller.toggleFlash();
                  setState(() {});
                } on PlatformException catch (e) {
                  _torchEnabled = false;
                  setState(() {});
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
