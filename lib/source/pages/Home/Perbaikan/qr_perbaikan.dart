import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class QRPerbaikan extends StatefulWidget {
  String? id_mesin;
  QRPerbaikan({super.key, this.id_mesin});

  @override
  State<QRPerbaikan> createState() => _QRPerbaikanState();
}

class _QRPerbaikanState extends State<QRPerbaikan> {
  String _scanBarcode = '';
  Future<void> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  @override
  void initState() {
    super.initState();
    scanQR();
  }

  @override
  Widget build(BuildContext context) {
    final argument = ModalRoute.of(context)!.settings.arguments as Map;
    print(argument['id_mesin']);
    return Scaffold(
      appBar: AppBar(
        title: Text("Scan QR"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Result Scan",
              style: TextStyle(fontSize: 16),
            ),
            Text(
              argument['id_mesin'].toString() == _scanBarcode
                  ? 'ID Mesin Matching'
                  : 'ID Mesin Tidak Sama',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
