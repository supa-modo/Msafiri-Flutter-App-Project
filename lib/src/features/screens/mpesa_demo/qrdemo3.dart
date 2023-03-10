import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrscan/qrscan.dart' as scan;

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late String scannedMsg = "";
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("QR Generator"),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Enter your string'),
            ),
            const SizedBox(
              height: 30,
            ),
            TextButton(
                onPressed: () {
                  setState(() {});
                },
                child: const Text("Generate QR")),
            TextButton(
                onPressed: () {
                  scanQr();
                },
                child: const Text("Scan QR")),
            const SizedBox(
              height: 50,
            ),
            Text(scannedMsg),
            const SizedBox(
              height: 100,
            ),
            QrImage(
              data: controller.text,
              size: 200.0,
            )
          ],
        ),
      ),
    );
  }

  void scanQr() async {
    String? scanResult = await scan.scan();
    scannedMsg = scanResult.toString();
    setState(() {});
  }
}
