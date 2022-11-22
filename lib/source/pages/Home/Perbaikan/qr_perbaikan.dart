import 'package:flutter/material.dart';

class QRPerbaikan extends StatefulWidget {
  String? id_mesin;
  QRPerbaikan({super.key, this.id_mesin});

  @override
  State<QRPerbaikan> createState() => _QRPerbaikanState();
}

class _QRPerbaikanState extends State<QRPerbaikan> {
  @override
  Widget build(BuildContext context) {
    final argument = ModalRoute.of(context)!.settings.arguments as Map;
    print(argument['id_mesin']);
    return Scaffold(
      appBar: AppBar(
        title: Text("Scan QR"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Result Scan"),
          
        ],
      ),
    );
  }
}
